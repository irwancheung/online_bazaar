import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/cart_exception.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';

class CustomerCartDataSource {
  final FirebaseFirestore _firestore;

  const CustomerCartDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<List<MenuItemModel>> getMenuItemsByCartItemIds(
    List<String> ids,
  ) async {
    try {
      final snapshot =
          await _itemsRef.where(FieldPath.documentId, whereIn: ids).get();

      return snapshot.docs
          .map((doc) => MenuItemModel.fromMap(doc.data()))
          .toList();
    } catch (e, s) {
      logger.error(e, s);
      throw const GetMenuItemsByCartItemIdsException();
    }
  }

  Future<FoodOrderModel> convertCartToFoodOrder(
    CompleteCheckoutParams params,
  ) async {
    try {
      final newFoodOrderId = await _firestore.runTransaction(
        (transaction) async {
          final cart = params.cart;
          final setting = params.setting;

          if (!cart.canCheckout) {
            return null;
          }

          for (final cartItem in cart.items) {
            final item = cartItem.item;
            final itemRef = _itemsRef.doc(item.id);

            final itemDoc = await transaction.get(itemRef);

            if (!itemDoc.exists || itemDoc.get('isVisible') == false) {
              throw const ConvertCartToFoodOrderException(
                'Item tidak ditemukan.',
              );
            }

            final dbItem = MenuItemModel.fromMap(itemDoc.data()!);

            if (dbItem.remainingQuantity < cartItem.quantity) {
              throw const ConvertCartToFoodOrderException('Stok tidak cukup.');
            }
          }

          int orderNumber = 1;

          final orderNumberPrefix = setting.foodOrder.orderNumberPrefix;
          final orderNumberPrefixRef =
              _foodOrderIdPrefixesRef.doc(orderNumberPrefix);

          final orderNumberPrefixDoc =
              await transaction.get(orderNumberPrefixRef);

          if (!orderNumberPrefixDoc.exists) {
            transaction.set(
              orderNumberPrefixRef,
              {
                'prefix': orderNumberPrefix,
                'lastOrderNumber': orderNumber,
              },
            );
          } else {
            orderNumber =
                (orderNumberPrefixDoc.data()!['lastOrderNumber'] as int) + 1;

            transaction.update(
              orderNumberPrefixRef,
              {'lastOrderNumber': orderNumber},
            );
          }

          for (final cartItem in cart.items) {
            final item = cartItem.item;
            final itemRef = _itemsRef.doc(item.id);

            transaction.update(
              itemRef,
              {
                'soldQuantity': FieldValue.increment(cartItem.quantity),
                'remainingQuantity': FieldValue.increment(-cartItem.quantity),
                'updatedAt': DateTime.now().millisecondsSinceEpoch,
              },
            );
          }

          final foodOrder = FoodOrderModel.fromCartAndSetting(cart, setting);
          final foodOrderId =
              '$orderNumberPrefix-${orderNumber.toString().padLeft(3, "0")}';
          final foodOrderDocRef = _foodOrdersRef.doc(foodOrderId);

          transaction.set(
            foodOrderDocRef,
            foodOrder.toMap()..['id'] = foodOrderId,
          );

          return foodOrderId;
        },
        maxAttempts: 1,
      );

      if (newFoodOrderId == null) {
        throw const ConvertCartToFoodOrderException();
      }

      final foodOrderSnapshot = await _foodOrdersRef.doc(newFoodOrderId).get();
      return FoodOrderModel.fromMap(foodOrderSnapshot.data()!);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      log(e.toString());
      throw const ConvertCartToFoodOrderException();
    }
  }

  CollectionReference<Map<String, dynamic>> get _itemsRef =>
      _firestore.collection('menu_items');

  CollectionReference<Map<String, dynamic>> get _foodOrdersRef =>
      _firestore.collection('food_orders');

  CollectionReference<Map<String, dynamic>> get _foodOrderIdPrefixesRef =>
      _firestore.collection('food_order_id_prefixes');
}
