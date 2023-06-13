import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

class FoodOrder extends Equatable {
  final String id;
  final Event event;
  final Payment payment;
  final Customer customer;
  final OrderType type;
  final OrderStatus status;
  final DeliveryAddress? deliveryAddress;
  final List<FoodOrderItem> items;
  final String note;
  final String? adminNote;
  final int totalQuantity;
  final int subTotalPrice;
  final int deliveryCharge;
  final int additionalCharge;
  final int discount;
  final int totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FoodOrder({
    required this.id,
    required this.event,
    required this.payment,
    required this.customer,
    required this.type,
    required this.status,
    this.deliveryAddress,
    required this.items,
    required this.note,
    this.adminNote,
    required this.totalQuantity,
    required this.subTotalPrice,
    required this.deliveryCharge,
    required this.additionalCharge,
    required this.discount,
    required this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  bool get canUpdateStatus =>
      status != OrderStatus.completed || status != OrderStatus.cancelled;

  String get statusText {
    switch (status) {
      case OrderStatus.paymentPending:
        return 'Menunggu Pembayaran';
      case OrderStatus.processing:
        return 'Sedang Diproses';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
      default:
        return 'Tidak Diketahui';
    }
  }

  @override
  List<Object?> get props => [
        id,
        customer,
        event,
        payment,
        type,
        status,
        deliveryAddress,
        items,
        note,
        adminNote,
        totalQuantity,
        subTotalPrice,
        deliveryCharge,
        additionalCharge,
        discount,
        totalPrice,
        createdAt,
        updatedAt,
      ];
}
