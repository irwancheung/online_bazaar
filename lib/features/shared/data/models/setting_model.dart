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
    required super.id,
    required super.event,
    required super.foodOrder,
    required super.payment,
    super.createdAt,
    super.updatedAt,
  });

  factory SettingModel.newSetting() {
    return SettingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      event: const EventSettingModel(name: '', pickupNote: ''),
      foodOrder: const FoodOrderSettingModel(orderNumberPrefix: ''),
      payment: const PaymentSettingModel(
        transferTo: '',
        transferNoteFormat: '',
        sendTransferProofTo: '',
      ),
    );
  }

  factory SettingModel.fromEntity(Setting setting) {
    return SettingModel(
      id: setting.id,
      event: setting.event,
      foodOrder: setting.foodOrder,
      payment: setting.payment,
      createdAt: setting.createdAt,
      updatedAt: setting.updatedAt,
    );
  }

  SettingModel copyWith({
    String? id,
    EventSetting? event,
    FoodOrderSetting? foodOrder,
    PaymentSetting? payment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SettingModel(
      id: id ?? this.id,
      event: event ?? this.event,
      foodOrder: foodOrder ?? this.foodOrder,
      payment: payment ?? this.payment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'event': EventSettingModel.fromEntity(event).toMap(),
      'foodOrder': FoodOrderSettingModel.fromEntity(foodOrder).toMap(),
      'payment': PaymentSettingModel.fromEntity(payment).toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      id: map['id'] as String,
      event: EventSettingModel.fromMap(map['event'] as Map<String, dynamic>),
      foodOrder: FoodOrderSettingModel.fromMap(
        map['foodOrder'] as Map<String, dynamic>,
      ),
      payment:
          PaymentSettingModel.fromMap(map['payment'] as Map<String, dynamic>),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
