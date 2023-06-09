import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_food_order_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';

import '../../../../helpers.dart';

void main() {
  initHelpersTest();

  late FakeFirebaseFirestore fakeFirestore;
  late AdminFoodOrderDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = AdminFoodOrderDataSource(firestore: fakeFirestore);
  });

  group('AdminFoodOrderDataSource', () {
    group('getFoodOrders()', () {
      test('should return Stream<List<FoodOrderModel>>.', () async {
        // Arrange
        await fakeFirestore.collection('food_orders').add(
              jsonDecode(fixture('food_order.json')) as Map<String, dynamic>,
            );

        // Act
        final result = dataSource.getFoodOrders();

        // Assert
        expect(result, isA<Stream<List<FoodOrderModel>>>());
      });
    });

    group('updateFoodOrderStatus()', () {
      test('should return FoodOrderModel from Firestore with new status.',
          () async {
        // Arrange
        final tOrder = FoodOrderModel.fromMap(
          jsonDecode(fixture('food_order.json')) as Map<String, dynamic>,
        );

        final tDocRef =
            await fakeFirestore.collection('food_orders').add(tOrder.toMap());

        // Act
        final result = await dataSource.updateFoodOrderStatus(
          UpdateFoodOrderStatusParams(
            id: tDocRef.id,
            status: OrderStatus.completed,
          ),
        );

        // Assert
        expect(result, isA<FoodOrderModel>());
        expect(result.status, equals(OrderStatus.completed));
      });
    });

    group('updateAdminNote()', () {
      test('should return FoodOrderModel from Firestore with new admin note.',
          () async {
        // Arrange
        final tOrder = FoodOrderModel.fromMap(
          jsonDecode(fixture('food_order.json')) as Map<String, dynamic>,
        );

        final tDocRef =
            await fakeFirestore.collection('food_orders').add(tOrder.toMap());

        // Act
        final result = await dataSource.updateAdminNote(
          UpdateAdminNoteParams(
            id: tDocRef.id,
            adminNote: 'Catatan admin.',
          ),
        );

        // Assert
        expect(result, isA<FoodOrderModel>());
        expect(result.adminNote, equals('Catatan admin.'));
      });
    });
  });
}
