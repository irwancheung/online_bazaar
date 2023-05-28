import 'dart:convert';

import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/data/models/cart_item_model.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/shared/data/models/customer_model.dart';
import 'package:online_bazaar/features/shared/data/models/delivery_address_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.items,
    required super.orderType,
    required super.paymentType,
    required super.note,
    required super.totalQuantity,
    required super.totalPrice,
    required super.canCheckout,
    super.customer,
    super.deliveryAddress,
    super.createdAt,
    super.updatedAt,
  });

  factory CartModel.newCart() {
    final now = DateTime.now();

    return CartModel(
      id: now.millisecondsSinceEpoch.toString(),
      items: const [],
      orderType: OrderType.pickup,
      paymentType: PaymentType.bankTransfer,
      note: '',
      totalQuantity: 0,
      totalPrice: 0,
      canCheckout: false,
      createdAt: now,
    );
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      id: cart.id,
      items: cart.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      customer: cart.customer,
      orderType: cart.orderType,
      paymentType: cart.paymentType,
      deliveryAddress: cart.deliveryAddress,
      note: cart.note,
      totalQuantity: cart.totalQuantity,
      totalPrice: cart.totalPrice,
      canCheckout: cart.canCheckout,
      createdAt: cart.createdAt,
      updatedAt: cart.updatedAt,
    );
  }

  CartModel copyWith({
    String? id,
    List<CartItem>? items,
    Customer? customer,
    OrderType? orderType,
    PaymentType? paymentType,
    DeliveryAddress? deliveryAddress,
    String? note,
    int? totalQuantity,
    int? totalPrice,
    bool? canCheckout,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      items: items ?? this.items,
      customer: customer ?? this.customer,
      orderType: orderType ?? this.orderType,
      paymentType: paymentType ?? this.paymentType,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      note: note ?? this.note,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      canCheckout: canCheckout ?? this.canCheckout,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'items':
          items.map((item) => CartItemModel.fromEntity(item).toMap()).toList(),
      'customer':
          customer != null ? CustomerModel.fromEntity(customer!).toMap() : null,
      'orderType': orderType.name,
      'paymentType': paymentType.name,
      'deliveryAddress': deliveryAddress != null
          ? DeliveryAddressModel.fromEntity(deliveryAddress!).toMap()
          : null,
      'note': note,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'canCheckout': canCheckout,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      items: List<CartItem>.from(
        (map['items'] as List<dynamic>).map<CartItem>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'] as Map<String, dynamic>)
          : null,
      orderType: (map['orderType'] as String).toOrderTypeEnum(),
      paymentType: (map['paymentType'] as String).toPaymentTypeEnum(),
      deliveryAddress: map['deliveryAddress'] != null
          ? DeliveryAddressModel.fromMap(
              map['deliveryAddress'] as Map<String, dynamic>,
            )
          : null,
      note: map['note'] as String,
      totalQuantity: map['totalQuantity'] as int,
      totalPrice: map['totalPrice'] as int,
      canCheckout: map['canCheckout'] as bool,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
