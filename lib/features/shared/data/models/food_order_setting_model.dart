import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';

class FoodOrderSettingModel extends FoodOrderSetting {
  const FoodOrderSettingModel({required super.orderNumberPrefix});

  factory FoodOrderSettingModel.fromEntity(
    FoodOrderSetting foodOrderSetting,
  ) {
    return FoodOrderSettingModel(
      orderNumberPrefix: foodOrderSetting.orderNumberPrefix,
    );
  }

  FoodOrderSetting copyWith({
    String? orderNumberPrefix,
  }) {
    return FoodOrderSetting(
      orderNumberPrefix: orderNumberPrefix ?? this.orderNumberPrefix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderNumberPrefix': orderNumberPrefix,
    };
  }

  factory FoodOrderSettingModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderSettingModel(
      orderNumberPrefix: map['orderNumberPrefix'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FoodOrderSettingModel.fromJson(String source) =>
      FoodOrderSettingModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
