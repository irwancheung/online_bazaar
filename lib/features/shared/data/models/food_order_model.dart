import 'dart:convert';

import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/shared/data/models/customer_model.dart';
import 'package:online_bazaar/features/shared/data/models/delivery_address_model.dart';
import 'package:online_bazaar/features/shared/data/models/event_model.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_item_model.dart';
import 'package:online_bazaar/features/shared/data/models/payment_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

class FoodOrderModel extends FoodOrder {
  const FoodOrderModel({
    required super.id,
    required super.event,
    required super.payment,
    required super.customer,
    required super.type,
    required super.status,
    super.deliveryAddress,
    required super.items,
    required super.note,
    super.adminNote,
    required super.totalQuantity,
    required super.subTotalPrice,
    required super.deliveryCharge,
    required super.additionalCharge,
    required super.discount,
    required super.totalPrice,
    super.createdAt,
    super.updatedAt,
  });

  factory FoodOrderModel.fromEntity(FoodOrder order) {
    return FoodOrderModel(
      id: order.id,
      event: order.event,
      payment: order.payment,
      customer: CustomerModel.fromEntity(order.customer),
      type: order.type,
      status: order.status,
      deliveryAddress: order.deliveryAddress,
      items: order.items
          .map((item) => FoodOrderItemModel.fromEntity(item))
          .toList(),
      note: order.note,
      adminNote: order.adminNote,
      totalQuantity: order.totalQuantity,
      subTotalPrice: order.subTotalPrice,
      deliveryCharge: order.deliveryCharge,
      additionalCharge: order.additionalCharge,
      discount: order.discount,
      totalPrice: order.totalPrice,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
    );
  }

  factory FoodOrderModel.fromCartAndSetting(Cart cart, Setting setting) {
    final now = DateTime.now();

    return FoodOrderModel(
      id: now.millisecondsSinceEpoch.toString(),
      event: EventModel.fromEventSetting(setting.event),
      payment: Payment(
        type: cart.paymentType,
        transferTo: setting.payment.transferTo,
        transferNoteFormat: setting.payment.transferNoteFormat,
        sendTransferProofTo: setting.payment.sendTransferProofTo,
      ),
      customer: cart.customer!,
      type: cart.orderType,
      status: OrderStatus.paymentPending,
      deliveryAddress: cart.deliveryAddress,
      items: cart.items
          .map((item) => FoodOrderItemModel.fromCartItem(item))
          .toList(),
      note: cart.note,
      totalQuantity: cart.totalQuantity,
      subTotalPrice: cart.totalPrice,
      deliveryCharge: 0,
      additionalCharge: 0,
      discount: 0,
      totalPrice: cart.totalPrice,
      createdAt: now,
    );
  }

  FoodOrderModel copyWith({
    String? id,
    Event? event,
    Payment? payment,
    Customer? customer,
    OrderType? type,
    PaymentType? paymentType,
    OrderStatus? status,
    DeliveryAddress? deliveryAddress,
    List<FoodOrderItem>? items,
    String? note,
    String? adminNote,
    int? totalQuantity,
    int? subTotalPrice,
    int? deliveryCharge,
    int? additionalCharge,
    int? discount,
    int? totalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodOrderModel(
      id: id ?? this.id,
      event: event ?? this.event,
      payment: payment ?? this.payment,
      customer: customer ?? this.customer,
      type: type ?? this.type,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      items: items ?? this.items,
      note: note ?? this.note,
      adminNote: adminNote ?? this.adminNote,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      subTotalPrice: subTotalPrice ?? this.subTotalPrice,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      additionalCharge: additionalCharge ?? this.additionalCharge,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'event': EventModel.fromEntity(event).toMap(),
      'payment': PaymentModel.fromEntity(payment).toMap(),
      'customer': CustomerModel.fromEntity(customer).toMap(),
      'type': type.name,
      'status': status.name,
      'deliveryAddress': deliveryAddress != null
          ? DeliveryAddressModel.fromEntity(deliveryAddress!).toMap()
          : null,
      'items': items
          .map((item) => FoodOrderItemModel.fromEntity(item).toMap())
          .toList(),
      'note': note,
      'adminNote': adminNote,
      'totalQuantity': totalQuantity,
      'subTotalPrice': subTotalPrice,
      'deliveryCharge': deliveryCharge,
      'additionalCharge': additionalCharge,
      'discount': discount,
      'totalPrice': totalPrice,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory FoodOrderModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderModel(
      id: map['id'] as String,
      event: EventModel.fromMap(map['event'] as Map<String, dynamic>),
      payment: PaymentModel.fromMap(map['payment'] as Map<String, dynamic>),
      customer: CustomerModel.fromMap(map['customer'] as Map<String, dynamic>),
      type: (map['type'] as String).toOrderTypeEnum(),
      status: (map['status'] as String).toOrderStatusEnum(),
      deliveryAddress: map['deliveryAddress'] != null
          ? DeliveryAddressModel.fromMap(
              map['deliveryAddress'] as Map<String, dynamic>,
            )
          : null,
      items: List<FoodOrderItem>.from(
        (map['items'] as List<dynamic>).map<FoodOrderItem>(
          (item) => FoodOrderItemModel.fromMap(item as Map<String, dynamic>),
        ),
      ),
      note: map['note'] as String,
      adminNote: map['adminNote'] as String?,
      totalQuantity: map['totalQuantity'] as int,
      subTotalPrice: map['subTotalPrice'] as int,
      deliveryCharge: map['deliveryCharge'] as int,
      additionalCharge: map['additionalCharge'] as int,
      discount: map['discount'] as int,
      totalPrice: map['totalPrice'] as int,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FoodOrderModel.fromJson(String source) =>
      FoodOrderModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
