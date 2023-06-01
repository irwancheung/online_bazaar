import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_config.dart';

class Config extends Equatable {
  final EventConfig event;
  final FoodOrderConfig foodOrder;
  final PaymentConfig payment;

  const Config({
    required this.event,
    required this.foodOrder,
    required this.payment,
  });

  @override
  List<Object?> get props => [event, foodOrder, payment];
}
