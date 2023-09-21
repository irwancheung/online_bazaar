import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/cart_exception.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_cart_data_source.dart';
import 'package:online_bazaar/features/customer/data/models/cart_item_model.dart';
import 'package:online_bazaar/features/customer/data/models/cart_model.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_cart_repository_impl.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import '../../../../helpers.dart';
import 'customer_cart_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<CustomerCartDataSource>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockCustomerCartDataSource mockDataSource;
  late CustomerCartRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockCustomerCartDataSource();
    repository = CustomerCartRepositoryImpl(
      networkInfo: mockNetworkInfo,
      dataSource: mockDataSource,
    );
  });

  void setInternetConnected() {
    when(mockNetworkInfo.checkConnection()).thenAnswer((_) async {});
  }

  void setInternetDisconnected() {
    when(mockNetworkInfo.checkConnection()).thenThrow(NetworkException());
  }

  void runInternetDisconnectedTests(Function() method) {
    test(
        'should check if is connected to internet and throw NetworkException when there is no internet connection.',
        () async {
      // Arrange
      setInternetDisconnected();

      // Assert
      expect(method, throwsA(isA<NetworkException>()));
    });
  }

  group('CustomerCartRepositoryImpl', () {
    const tItem = MenuItem(
      id: 'id',
      name: 'name',
      image: 'image',
      variants: [],
      sellingPrice: 0,
      soldQuantity: 0,
      remainingQuantity: 10,
      isVisible: true,
    );

    group('setCartCustomer()', () {
      test('should return Cart with new customer.', () async {
        // Arrange
        final tCart = CartModel.newCart();
        const tCustomer = Customer(
          id: 'id',
          email: 'email',
          name: 'name',
          chaitya: 'chaitya',
          phone: 'phone',
          address: 'address',
        );

        // Act
        final result = await repository.setCartCustomer(
          SetCartCustomerParams(
            cart: tCart,
            customer: tCustomer,
          ),
        );

        expect(result.customer, tCustomer);
      });
    });

    group('addCartItem()', () {
      test('should return Cart with new item.', () async {
        // Arrange
        final tCart = CartModel.newCart();
        const tItem = MenuItem(
          id: 'id',
          name: 'name',
          image: 'image',
          variants: [],
          sellingPrice: 0,
          soldQuantity: 0,
          remainingQuantity: 1,
          isVisible: true,
        );

        // Act
        final result = await repository.addCartItem(
          AddCartItemParams(
            cart: tCart,
            item: tItem,
            variant: '',
            quantity: 1,
            note: '',
          ),
        );

        expect(result.items.length, greaterThan(tCart.items.length));
      });

      test('should throw AddCartItemException when failed.', () async {
        // Arrange
        final tCart = CartModel.newCart();

        // Act
        final call = repository.addCartItem;

        expect(
          call(
            AddCartItemParams(
              cart: tCart,
              item: tItem,
              variant: 'variant_1',
              quantity: 1,
              note: '',
            ),
          ),
          throwsA(isA<AddCartItemException>()),
        );
      });
    });

    group('updateCartItem()', () {
      test('should return Cart with updated item if exists.', () async {
        // Arrange
        final tCart = CartModel.newCart().copyWith(
          items: [
            const CartItemModel(
              id: 'id',
              item: tItem,
              variant: '',
              quantity: 1,
              note: '',
            ),
          ],
        );

        // Act
        final result = await repository.updateCartItem(
          UpdateCartItemParams(
            cart: tCart,
            cartItemId: tItem.id,
            variant: '',
            quantity: 2,
            note: '',
          ),
        );

        // Assert
        expect(result.items.length, equals(tCart.items.length));
        expect(result.items[0].quantity, equals(2));
      });

      test('should throw UpdateCartItemException when failed.', () async {
        // Arrange
        final tCart = CartModel.newCart().copyWith(
          items: [
            const CartItemModel(
              id: 'id',
              item: tItem,
              variant: '',
              quantity: 1,
              note: '',
            ),
          ],
        );

        // Act
        final call = repository.updateCartItem;

        expect(
          call(
            UpdateCartItemParams(
              cart: tCart,
              cartItemId: 'id_2',
              variant: '',
              quantity: 2,
              note: '',
            ),
          ),
          throwsA(isA<UpdateCartItemException>()),
        );
      });
    });

    group('removeCartItem()', () {
      test('should return Cart with less items.', () async {
        // Arrange
        final tCart = CartModel.newCart().copyWith(
          items: [
            const CartItemModel(
              id: 'id',
              item: tItem,
              variant: '',
              quantity: 1,
              note: '',
            ),
          ],
        );
        // Act
        final result = await repository.removeCartItem(
          RemoveCartItemParams(
            cart: tCart,
            cartItemId: 'id',
          ),
        );

        // Assert result cart items is empty
        expect(result.items.length, equals(0));
      });
    });

    group('validateCart()', () {
      final tMenuItemModel = MenuItemModel.fromJson(fixture('menu_item.json'));
      final tCart = CartModel.newCart().copyWith(
        items: [
          CartItem(
            id: 'id',
            item: tMenuItemModel.copyWith(remainingQuantity: 2),
            variant: 'Regular',
            quantity: 1,
            note: '',
          ),
        ],
      );

      final tValidateCartParams = ValidateCartParams(cart: tCart);

      runInternetDisconnectedTests(
        () => repository.validateCart(tValidateCartParams),
      );

      test(
          'should return Cart where each CartItem has updated Item from firestore.',
          () async {
        // Arrange
        setInternetConnected();
        when(mockDataSource.getMenuItemsByCartItemIds(any))
            .thenAnswer((_) async => [tMenuItemModel]);

        // Act
        final result = await repository.validateCart(tValidateCartParams);

        // Assert
        expect(result.items[0].item, equals(tMenuItemModel));
      });

      test('should throw AppException when failed.', () async {
        // Arrange
        setInternetDisconnected();

        // Act
        final call = repository.validateCart;

        // Assert
        expect(call(tValidateCartParams), throwsA(isA<AppException>()));
      });
    });

    group('completeCheckout()', () {
      final tItem = MenuItemModel.fromJson(fixture('menu_item.json'));

      final tCart = Cart(
        id: 'id ',
        customer: const Customer(
          id: 'id',
          email: 'email',
          name: 'name',
          chaitya: 'chaitya',
          phone: 'phone',
          address: 'address',
        ),
        orderType: OrderType.pickup,
        paymentType: PaymentType.cash,
        note: '',
        totalPrice: 120,
        totalQuantity: 1,
        canCheckout: true,
        items: [
          CartItem(
            id: 'id',
            variant: 'Regular',
            note: '',
            item: tItem,
            quantity: 1,
          ),
        ],
      );

      final tSetting = Setting(
        id: 'id',
        event: EventSetting(
          name: 'name',
          pickupNote: 'pickupNote',
          startAt: DateTime.utc(0),
          endAt: DateTime.now().add(const Duration(days: 1)),
        ),
        foodOrder:
            const FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
        payment: const PaymentSetting(
          transferTo: 'transferTo',
          transferNoteFormat: 'transferNoteFormat',
          sendTransferProofTo: 'sendTransferProofTo',
        ),
      );

      final tCompleteCheckoutParams = CompleteCheckoutParams(
        cart: tCart,
        orderType: OrderType.pickup,
        paymentType: PaymentType.cash,
        note: '',
        setting: tSetting,
      );

      final tFoodOrder = FoodOrderModel.fromCartAndSetting(tCart, tSetting);

      test('should return FoodOrder where properties value is same as Cart.',
          () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.convertCartToFoodOrder(any))
            .thenAnswer((_) async => tFoodOrder);

        // Act
        final result =
            await repository.completeCheckout(tCompleteCheckoutParams);

        // Assert
        expect(result, equals(tFoodOrder));
      });

      test('should throw AppException when failed.', () async {
        // Arrange
        setInternetDisconnected();

        // Act
        final call = repository.completeCheckout;

        // Assert
        expect(call(tCompleteCheckoutParams), throwsA(isA<AppException>()));
      });
    });
  });
}
