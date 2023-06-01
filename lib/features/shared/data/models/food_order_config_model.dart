import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/food_order_config.dart';

class FoodOrderConfigModel extends FoodOrderConfig {
  const FoodOrderConfigModel({required super.orderNumberPrefix});

  factory FoodOrderConfigModel.fromEntity(
    FoodOrderConfig foodOrderConfig,
  ) {
    return FoodOrderConfigModel(
      orderNumberPrefix: foodOrderConfig.orderNumberPrefix,
    );
  }

  FoodOrderConfig copyWith({
    String? orderNumberPrefix,
  }) {
    return FoodOrderConfig(
      orderNumberPrefix: orderNumberPrefix ?? this.orderNumberPrefix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderNumberPrefix': orderNumberPrefix,
    };
  }

  factory FoodOrderConfigModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderConfigModel(
      orderNumberPrefix: map['orderNumberPrefix'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FoodOrderConfigModel.fromJson(String source) =>
      FoodOrderConfigModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
