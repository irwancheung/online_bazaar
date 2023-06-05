import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';

class AdminFoodOrderDataSource {
  final FirebaseFirestore _firestore;

  const AdminFoodOrderDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<FoodOrderModel>> getFoodOrders() {
    return _foodOrdersRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FoodOrderModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<FoodOrderModel> updateFoodOrderStatus(
    UpdateFoodOrderStatusParams params,
  ) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final currentOrderRef = _foodOrdersRef.doc(params.id);
        final currentOrderDoc = await transaction.get(currentOrderRef);

        if (!currentOrderDoc.exists) {
          throw const UpdateFoodOrderStatusException(
            'Pesanan tidak ditemukan.',
          );
        }

        final order = FoodOrderModel.fromMap(currentOrderDoc.data()!);

        switch (order.status) {
          case OrderStatus.completed:
          case OrderStatus.cancelled:
            throw const UpdateFoodOrderStatusException(
              'Pesanan sudah selesai atau dibatalkan.',
            );
          case OrderStatus.processing:
            if (params.status == OrderStatus.paymentPending) {
              throw const UpdateFoodOrderStatusException(
                'Pesanan sudah dibayar.',
              );
            }
          default:
            break;
        }

        if (params.status == OrderStatus.cancelled) {
          for (final orderItem in order.items) {
            final itemRef = _itemsRef.doc(orderItem.item.id);

            transaction.update(itemRef, {
              'soldQuantity': FieldValue.increment(-orderItem.quantity),
              'remainingQuantity': FieldValue.increment(orderItem.quantity),
              'updatedAt': DateTime.now().millisecondsSinceEpoch,
            });
          }
        }

        transaction.update(currentOrderRef, {
          'status': params.status.name,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        });
      });

      final newOrderSnapshot = await _foodOrdersRef.doc(params.id).get();
      return FoodOrderModel.fromMap(newOrderSnapshot.data()!);
    } catch (e, s) {
      logger.error(e, s);
      throw const UpdateFoodOrderStatusException();
    }
  }

  CollectionReference<Map<String, dynamic>> get _itemsRef =>
      _firestore.collection('menu_items');

  CollectionReference<Map<String, dynamic>> get _foodOrdersRef =>
      _firestore.collection('food_orders');
}
