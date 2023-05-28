import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

void main() {
  final tFoodOrderModel = FoodOrderModel(
    id: 'id',
    event: Event(
      id: 'id',
      title: 'title',
      pickupNote: 'pickupNote',
      startAt: DateTime.utc(0),
      endAt: DateTime.utc(0),
    ),
    customer: const Customer(
      id: 'id',
      email: 'email',
      name: 'name',
      chaitya: 'chaitya',
      phone: 'phone',
      address: 'address',
    ),
    type: OrderType.delivery,
    paymentType: PaymentType.bankTransfer,
    status: OrderStatus.completed,
    items: const [],
    note: 'note',
    totalQuantity: 0,
    subTotalPrice: 0,
    deliveryCharge: 0,
    additionalCharge: 0,
    discount: 0,
    totalPrice: 0,
  );

  group('FoodOrderModel', () {
    test('should be a subclass of FoodOrder entity.', () async {
      // assert
      expect(tFoodOrderModel, isA<FoodOrder>());
    });
  });
}
