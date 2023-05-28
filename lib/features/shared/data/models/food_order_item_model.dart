import 'dart:convert';

import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class FoodOrderItemModel extends FoodOrderItem {
  const FoodOrderItemModel({
    required super.id,
    required super.item,
    required super.name,
    required super.image,
    required super.variant,
    required super.quantity,
    required super.price,
    required super.note,
    super.createdAt,
    super.updatedAt,
  });

  factory FoodOrderItemModel.fromEntity(FoodOrderItem item) {
    return FoodOrderItemModel(
      id: item.id,
      item: item.item,
      name: item.name,
      image: item.image,
      variant: item.variant,
      quantity: item.quantity,
      price: item.price,
      note: item.note,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  factory FoodOrderItemModel.fromCartItem(CartItem cartItem) {
    final now = DateTime.now();

    return FoodOrderItemModel(
      id: now.millisecondsSinceEpoch.toString(),
      item: cartItem.item,
      name: cartItem.item.name,
      image: cartItem.item.image,
      variant: cartItem.variant,
      quantity: cartItem.quantity,
      price: cartItem.item.sellingPrice,
      note: cartItem.note,
      createdAt: now,
    );
  }

  FoodOrderItem copyWith({
    String? id,
    MenuItem? item,
    String? name,
    String? image,
    String? variant,
    int? quantity,
    int? price,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodOrderItemModel(
      id: id ?? this.id,
      item: item ?? this.item,
      name: name ?? this.name,
      image: image ?? this.image,
      variant: variant ?? this.variant,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': MenuItemModel.fromEntity(item).toMap(),
      'name': name,
      'image': image,
      'variant': variant,
      'quantity': quantity,
      'price': price,
      'note': note,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory FoodOrderItemModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderItemModel(
      id: map['id'] as String,
      item: MenuItemModel.fromMap(map['item'] as Map<String, dynamic>),
      name: map['name'] as String,
      image: map['image'] as String,
      variant: map['variant'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      note: map['note'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FoodOrderItemModel.fromJson(String source) =>
      FoodOrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
