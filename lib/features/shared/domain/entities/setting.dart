import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

class Setting extends Equatable {
  final EventSetting event;
  final FoodOrderSetting foodOrder;
  final PaymentSetting payment;

  const Setting({
    required this.event,
    required this.foodOrder,
    required this.payment,
  });

  @override
  List<Object?> get props => [event, foodOrder, payment];
}
