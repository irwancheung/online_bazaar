import 'dart:convert';

import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.item,
    required super.variant,
    required super.quantity,
    required super.note,
    super.createdAt,
    super.updatedAt,
  });

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      id: item.id,
      item: item.item,
      variant: item.variant,
      quantity: item.quantity,
      note: item.note,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  CartItemModel copyWith({
    String? id,
    MenuItem? item,
    String? variant,
    int? quantity,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      item: item ?? this.item,
      variant: variant ?? this.variant,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'item': MenuItemModel.fromEntity(item).toMap(),
      'variant': variant,
      'quantity': quantity,
      'note': note,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      item: MenuItemModel.fromMap(map['item'] as Map<String, dynamic>),
      variant: map['variant'] as String,
      quantity: map['quantity'] as int,
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

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
