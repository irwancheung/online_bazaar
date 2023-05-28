import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_cart_data_source.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';

import '../../../../helpers.dart';

void main() {
  initHelpersTest();

  late FakeFirebaseFirestore fakeFirestore;
  late CustomerCartDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = CustomerCartDataSource(firestore: fakeFirestore);
  });

  group('CustomerCartDataSource', () {
    group('getMenuItems()', () {
      test('should return List<MenuItemModel>.', () async {
        // Arrange
        await fakeFirestore
            .collection('menu_items')
            .add(jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>);

        // Act
        final result = await dataSource.getMenuItemsByCartItemIds(['1']);

        // Assert
        expect(result, isA<List<MenuItemModel>>());
      });
    });

    group('convertCartToFoodOrder()', () {
      test('should return FoodOrderModel.', () async {
        // Arrange
        final tItemMap =
            jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>;
        final tItem = MenuItemModel.fromMap(tItemMap);

        final tEvent = Event(
          id: 'id',
          title: 'title',
          pickupNote: 'pickupNote',
          startAt: DateTime.utc(0),
          endAt: DateTime.utc(0),
        );

        final tDocRef =
            await fakeFirestore.collection('menu_items').add(tItemMap);

        final now = DateTime.now();

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
              item: MenuItemModel.fromEntity(tItem).copyWith(id: tDocRef.id),
              quantity: 1,
              createdAt: now,
            ),
          ],
          createdAt: now,
        );

        final tParams = CompleteCheckoutParams(
          cart: tCart,
          orderType: OrderType.pickup,
          paymentType: PaymentType.bankTransfer,
          note: 'note',
          event: tEvent,
        );

        // Act
        final result = await dataSource.convertCartToFoodOrder(tParams);

        // Assert
        expect(result, isA<FoodOrderModel>());
      });
    });
  });
}
