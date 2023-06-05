import 'dart:convert';

import 'package:online_bazaar/features/shared/data/models/event_setting_model.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_setting_model.dart';
import 'package:online_bazaar/features/shared/data/models/payment_setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

class SettingModel extends Setting {
  const SettingModel({
    required super.event,
    required super.foodOrder,
    required super.payment,
  });

  Setting copyWith({
    EventSetting? event,
    FoodOrderSetting? foodOrder,
    PaymentSetting? payment,
  }) {
    return Setting(
      event: event ?? this.event,
      foodOrder: foodOrder ?? this.foodOrder,
      payment: payment ?? this.payment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': EventSettingModel.fromEntity(event).toMap(),
      'foodOrder': FoodOrderSettingModel.fromEntity(foodOrder).toMap(),
      'payment': PaymentSettingModel.fromEntity(payment).toMap(),
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      event: EventSettingModel.fromMap(map['event'] as Map<String, dynamic>),
      foodOrder: FoodOrderSettingModel.fromMap(
        map['foodOrder'] as Map<String, dynamic>,
      ),
      payment:
          PaymentSettingModel.fromMap(map['payment'] as Map<String, dynamic>),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
