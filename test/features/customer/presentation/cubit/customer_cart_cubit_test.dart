import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/cart_exception.dart';
import 'package:online_bazaar/features/customer/data/models/cart_model.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/shared/data/models/event_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import '../../../../helpers.dart';
import 'customer_cart_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerCartRepository>()])
void main() {
  initHelpersTest();

  late MockCustomerCartRepository mockRepository;
  late CustomerCartCubit cubit;

  setUp(() {
    mockRepository = MockCustomerCartRepository();
    cubit = CustomerCartCubit(repository: mockRepository);
  });

  group('CustomerCartCubit', () {
    final tCart = CartModel.newCart();

    const tCustomer = Customer(
      id: 'id',
      email: 'email',
      name: 'name',
      chaitya: 'chaitya',
      phone: 'phone',
      address: 'address,',
    );

    const tItem = MenuItem(
      id: 'id',
      name: 'name',
      image: 'image',
      variants: [],
      sellingPrice: 100,
      soldQuantity: 0,
      remainingQuantity: 10,
      isVisible: true,
    );

    test('initial state should be CustomerCartState with non-null cart.', () {
      expect(cubit.state.cart, isNotNull);
    });

    group('setCartCustomer()', () {
      final tSetCartCustomerParams = SetCartCustomerParams(
        cart: tCart,
        customer: tCustomer,
      );

      test('should call repository.setCartCustomer() once.', () async {
        // Assert
        when(mockRepository.setCartCustomer(any))
            .thenAnswer((_) async => tCart);

        // Act
        cubit.setCartCustomer(tSetCartCustomerParams);
        await untilCalled(mockRepository.setCartCustomer(any));

        // Assert
        verify(mockRepository.setCartCustomer(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [SetCartCustomerLoadingState, SetCartCustomerSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.setCartCustomer(any))
              .thenAnswer((_) async => tCart);
        },
        build: () => cubit,
        act: (cubit) => cubit.setCartCustomer(tSetCartCustomerParams),
        expect: () => <CustomerCartState>[
          SetCartCustomerLoadingState(cart: tCart),
          SetCartCustomerSuccessState(cart: tCart),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [SetCartCustomerLoadingState, SetCartCustomerFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.setCartCustomer(any))
              .thenThrow(const SetCartCustomerException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.setCartCustomer(tSetCartCustomerParams),
        expect: () => <CustomerCartState>[
          SetCartCustomerLoadingState(cart: tCart),
          SetCartCustomerFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });

    group('addCartItem()', () {
      final tAddCartItemParams = AddCartItemParams(
        cart: tCart,
        item: tItem,
        variant: '',
        quantity: 1,
        note: '',
      );

      test('should call repository.addCartItem() once.', () async {
        // Assert
        when(mockRepository.addCartItem(any)).thenAnswer((_) async => tCart);

        // Act
        cubit.addCartItem(tAddCartItemParams);
        await untilCalled(mockRepository.addCartItem(any));

        // Assert
        verify(mockRepository.addCartItem(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [AddCartItemLoadingState, AddCartItemSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.addCartItem(any)).thenAnswer((_) async => tCart);
        },
        build: () => cubit,
        act: (cubit) => cubit.addCartItem(tAddCartItemParams),
        expect: () => <CustomerCartState>[
          AddCartItemLoadingState(cart: tCart),
          AddCartItemSuccessState(cart: tCart),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [AddCartItemLoadingState, AddCartItemFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.addCartItem(any))
              .thenThrow(const AddCartItemException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.addCartItem(tAddCartItemParams),
        expect: () => <CustomerCartState>[
          AddCartItemLoadingState(cart: tCart),
          AddCartItemFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });

    group('updateCartItem()', () {
      final tUpdateCartItemParams = UpdateCartItemParams(
        cart: tCart,
        cartItemId: 'id',
        variant: '',
        quantity: 1,
        note: '',
      );

      test('should call repository.updateCartItem() once.', () async {
        // Assert
        when(mockRepository.updateCartItem(any)).thenAnswer((_) async => tCart);

        // Act
        cubit.updateCartItem(tUpdateCartItemParams);
        await untilCalled(mockRepository.updateCartItem(any));

        // Assert
        verify(mockRepository.updateCartItem(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [UpdateCartItemLoadingState, UpdateCartItemSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.updateCartItem(any))
              .thenAnswer((_) async => tCart);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateCartItem(tUpdateCartItemParams),
        expect: () => <CustomerCartState>[
          UpdateCartItemLoadingState(cart: tCart),
          UpdateCartItemSuccessState(cart: tCart),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [UpdateCartItemLoadingState, UpdateCartItemFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.updateCartItem(any))
              .thenThrow(const UpdateCartItemException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.updateCartItem(tUpdateCartItemParams),
        expect: () => <CustomerCartState>[
          UpdateCartItemLoadingState(cart: tCart),
          UpdateCartItemFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });

    group('removeCartItem()', () {
      final tRemoveCartItemParams = RemoveCartItemParams(
        cart: tCart,
        cartItemId: 'id',
      );

      test('should call repository.removeCartItem() once.', () async {
        // Assert
        when(mockRepository.removeCartItem(any)).thenAnswer((_) async => tCart);

        // Act
        cubit.removeCartItem(tRemoveCartItemParams);
        await untilCalled(mockRepository.removeCartItem(any));

        // Assert
        verify(mockRepository.removeCartItem(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [RemoveCartItemLoadingState, RemoveCartItemSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.removeCartItem(any))
              .thenAnswer((_) async => tCart);
        },
        build: () => cubit,
        act: (cubit) => cubit.removeCartItem(tRemoveCartItemParams),
        expect: () => <CustomerCartState>[
          RemoveCartItemLoadingState(cart: tCart),
          RemoveCartItemSuccessState(cart: tCart),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [RemoveCartItemLoadingState, RemoveCartItemFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.removeCartItem(any))
              .thenThrow(const RemoveCartItemException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.removeCartItem(tRemoveCartItemParams),
        expect: () => <CustomerCartState>[
          RemoveCartItemLoadingState(cart: tCart),
          RemoveCartItemFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });

    group('validateCart()', () {
      test('should call repository.validateCart() once.', () async {
        // Assert
        when(mockRepository.validateCart(any)).thenAnswer((_) async => tCart);

        // Act
        cubit.validateCart();
        await untilCalled(mockRepository.validateCart(any));

        // Assert
        verify(mockRepository.validateCart(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [ValidateCartLoadingState, ValidateCartSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.validateCart(any)).thenAnswer((_) async => tCart);
        },
        build: () => cubit,
        act: (cubit) => cubit.validateCart(),
        expect: () => <CustomerCartState>[
          ValidateCartLoadingState(cart: tCart),
          ValidateCartSuccessState(cart: tCart),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [ValidateCartLoadingState, ValidateCartFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.validateCart(any))
              .thenThrow(const ValidateCartException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.validateCart(),
        expect: () => <CustomerCartState>[
          ValidateCartLoadingState(cart: tCart),
          ValidateCartFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });

    group('completeCheckout()', () {
      final tSetting = Setting(
        id: 'id',
        event: EventSetting(
          name: 'name',
          pickupNote: 'pickupNote',
          startAt: DateTime.utc(0),
          endAt: DateTime.utc(0),
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

      final tFoodOrder = FoodOrder(
        id: 'id',
        event: EventModel.fromEventSetting(tSetting.event),
        payment: Payment(
          type: tCompleteCheckoutParams.paymentType,
          transferTo: tSetting.payment.transferTo,
          transferNoteFormat: tSetting.payment.transferNoteFormat,
          sendTransferProofTo: tSetting.payment.sendTransferProofTo,
        ),
        customer: tCustomer,
        type: OrderType.pickup,
        status: OrderStatus.paymentPending,
        items: const [],
        note: '',
        totalQuantity: 0,
        subTotalPrice: 0,
        deliveryCharge: 0,
        additionalCharge: 0,
        discount: 0,
        totalPrice: 0,
      );

      test('should call repository.completeCheckout() once.', () async {
        // Assert
        when(mockRepository.completeCheckout(any))
            .thenAnswer((_) async => tFoodOrder);

        // Act
        cubit.completeCheckout(tCompleteCheckoutParams);
        await untilCalled(mockRepository.completeCheckout(any));

        // Assert
        verify(mockRepository.completeCheckout(any)).called(1);
      });

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [CompleteCheckoutLoadingState, CompleteCheckoutSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.completeCheckout(any))
              .thenAnswer((_) async => tFoodOrder);
        },
        build: () => cubit,
        act: (cubit) => cubit.completeCheckout(tCompleteCheckoutParams),
        expect: () => <CustomerCartState>[
          CompleteCheckoutLoadingState(cart: tCart),
          CompleteCheckoutSuccessState(
            foodOrder: tFoodOrder,
            cart: tCart,
          ),
        ],
      );

      blocTest<CustomerCartCubit, CustomerCartState>(
        'emits [CompleteCheckoutLoadingState, CompleteCheckoutFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.completeCheckout(any))
              .thenThrow(const CompleteCheckoutException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.completeCheckout(tCompleteCheckoutParams),
        expect: () => <CustomerCartState>[
          CompleteCheckoutLoadingState(cart: tCart),
          CompleteCheckoutFailureState(cart: tCart, errorMessage: ''),
        ],
      );
    });
  });
}
