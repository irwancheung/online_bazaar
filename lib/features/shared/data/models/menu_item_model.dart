import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.image,
    required super.variants,
    required super.sellingPrice,
    required super.soldQuantity,
    required super.remainingQuantity,
    required super.isVisible,
    super.createdAt,
    super.updatedAt,
  });

  factory MenuItemModel.fromEntity(MenuItem item) {
    return MenuItemModel(
      id: item.id,
      name: item.name,
      image: item.image,
      variants: item.variants,
      sellingPrice: item.sellingPrice,
      soldQuantity: item.soldQuantity,
      remainingQuantity: item.remainingQuantity,
      isVisible: item.isVisible,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  MenuItem copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? variants,
    int? sellingPrice,
    int? soldQuantity,
    int? remainingQuantity,
    bool? isVisible,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      variants: variants ?? this.variants,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      soldQuantity: soldQuantity ?? this.soldQuantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      isVisible: isVisible ?? this.isVisible,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'variants': variants,
      'sellingPrice': sellingPrice,
      'soldQuantity': soldQuantity,
      'remainingQuantity': remainingQuantity,
      'isVisible': isVisible,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      variants: List<String>.from(map['variants'] as List<dynamic>),
      sellingPrice: map['sellingPrice'] as int,
      soldQuantity: map['soldQuantity'] as int,
      remainingQuantity: map['remainingQuantity'] as int,
      isVisible: map['isVisible'] as bool,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory MenuItemModel.fromJson(String source) =>
      MenuItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
