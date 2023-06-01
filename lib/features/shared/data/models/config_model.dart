import 'dart:convert';

import 'package:online_bazaar/features/shared/data/models/event_config_model.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_config_model.dart';
import 'package:online_bazaar/features/shared/data/models/payment_config_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/config.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_config.dart';

class ConfigModel extends Config {
  const ConfigModel({
    required super.event,
    required super.foodOrder,
    required super.payment,
  });

  Config copyWith({
    EventConfig? event,
    FoodOrderConfig? foodOrder,
    PaymentConfig? payment,
  }) {
    return Config(
      event: event ?? this.event,
      foodOrder: foodOrder ?? this.foodOrder,
      payment: payment ?? this.payment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': EventConfigModel.fromEntity(event).toMap(),
      'foodOrder': FoodOrderConfigModel.fromEntity(foodOrder).toMap(),
      'payment': PaymentConfigModel.fromEntity(payment).toMap(),
    };
  }

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      event: EventConfigModel.fromMap(map['event'] as Map<String, dynamic>),
      foodOrder: FoodOrderConfigModel.fromMap(
        map['foodOrder'] as Map<String, dynamic>,
      ),
      payment:
          PaymentConfigModel.fromMap(map['payment'] as Map<String, dynamic>),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ConfigModel.fromJson(String source) =>
      ConfigModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
