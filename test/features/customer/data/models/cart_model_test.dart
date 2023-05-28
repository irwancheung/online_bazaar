import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/customer/data/models/cart_model.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

void main() {
  group('CartModel', () {
    test('should be a subclass of Cart entity.', () {
      // Arrange
      const tCartModel = CartModel(
        id: 'id',
        items: [],
        customer: Customer(
          id: 'id',
          email: 'email',
          name: 'name',
          chaitya: 'chaitya',
          phone: 'phone',
          address: 'address',
        ),
        orderType: OrderType.pickup,
        paymentType: PaymentType.cash,
        note: 'note',
        totalQuantity: 0,
        totalPrice: 0,
        canCheckout: false,
      );

      // assert
      expect(tCartModel, isA<Cart>());
    });
  });
}
