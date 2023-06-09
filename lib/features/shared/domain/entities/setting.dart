import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

class Setting extends Equatable {
  final String id;
  final EventSetting event;
  final FoodOrderSetting foodOrder;
  final PaymentSetting payment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Setting({
    required this.id,
    required this.event,
    required this.foodOrder,
    required this.payment,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, event, foodOrder, payment, createdAt, updatedAt];
}
