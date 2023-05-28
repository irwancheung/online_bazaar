import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';

class Cart extends Equatable {
  final String id;
  final List<CartItem> items;
  final Customer? customer;
  final OrderType orderType;
  final PaymentType paymentType;
  final DeliveryAddress? deliveryAddress;
  final String note;
  final int totalQuantity;
  final int totalPrice;
  final bool canCheckout;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Cart({
    required this.id,
    required this.items,
    this.customer,
    required this.orderType,
    required this.paymentType,
    this.deliveryAddress,
    required this.note,
    required this.totalQuantity,
    required this.totalPrice,
    required this.canCheckout,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        // id,
        items,
        customer,
        orderType,
        paymentType,
        deliveryAddress,
        note,
        totalQuantity,
        totalPrice,
        canCheckout,
        // createdAt,
        updatedAt,
      ];
}
