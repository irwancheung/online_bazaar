import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

abstract class CustomerCartRepository {
  Future<Cart> setCartCustomer(SetCartCustomerParams customer);
  Future<Cart> addCartItem(AddCartItemParams params);
  Future<Cart> updateCartItem(UpdateCartItemParams params);
  Future<Cart> removeCartItem(RemoveCartItemParams params);
  Future<Cart> validateCart(ValidateCartParams params);
  Future<FoodOrder> completeCheckout(CompleteCheckoutParams params);
}

class SetCartCustomerParams extends Equatable {
  final Cart cart;
  final Customer customer;

  const SetCartCustomerParams({
    required this.cart,
    required this.customer,
  });

  @override
  List<Object?> get props => [cart, customer];
}

class AddCartItemParams extends Equatable {
  final Cart cart;
  final MenuItem item;
  final String variant;
  final int quantity;
  final String note;

  const AddCartItemParams({
    required this.cart,
    required this.item,
    required this.variant,
    required this.quantity,
    required this.note,
  });

  @override
  List<Object?> get props => [cart, item, variant, quantity, note];
}

class UpdateCartItemParams extends Equatable {
  final Cart cart;
  final String cartItemId;
  final String variant;
  final int quantity;
  final String note;

  const UpdateCartItemParams({
    required this.cart,
    required this.cartItemId,
    required this.variant,
    required this.quantity,
    required this.note,
  });

  @override
  List<Object?> get props => [cart, cartItemId, variant, quantity, note];
}

class RemoveCartItemParams extends Equatable {
  final Cart cart;
  final String cartItemId;

  const RemoveCartItemParams({
    required this.cart,
    required this.cartItemId,
  });

  @override
  List<Object?> get props => [cart, cartItemId];
}

class ValidateCartParams extends Equatable {
  final Cart cart;

  const ValidateCartParams({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class CompleteCheckoutParams extends Equatable {
  final Cart cart;
  final OrderType orderType;
  final PaymentType paymentType;
  final String note;
  final Event event;
  final DeliveryAddress? deliveryAddress;

  const CompleteCheckoutParams({
    required this.cart,
    required this.orderType,
    required this.paymentType,
    required this.note,
    required this.event,
    this.deliveryAddress,
  });

  CompleteCheckoutParams copyWith({
    Cart? cart,
    OrderType? orderType,
    PaymentType? paymentType,
    String? note,
    Event? event,
    DeliveryAddress? deliveryAddress,
  }) {
    return CompleteCheckoutParams(
      cart: cart ?? this.cart,
      orderType: orderType ?? this.orderType,
      paymentType: paymentType ?? this.paymentType,
      note: note ?? this.note,
      event: event ?? this.event,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }

  @override
  List<Object?> get props => [
        cart,
        orderType,
        paymentType,
        note,
        event,
        deliveryAddress,
      ];
}
