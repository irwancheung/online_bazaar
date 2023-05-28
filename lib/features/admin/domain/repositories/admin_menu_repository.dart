import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

abstract class AdminMenuRepository {
  Stream<List<MenuItem>> getMenuItems();
  Future<MenuItem> addMenuItem(AddMenuItemParams params);
  Future<MenuItem> updateMenuItem(UpdateMenuItemParams params);
  Future<MenuItem> setMenuItemVisibility(SetMenuItemVisibilityParams params);
}

class AddMenuItemParams extends Equatable {
  final String name;
  final String image;
  final List<String> variants;
  final int sellingPrice;
  final int remainingQuantity;

  const AddMenuItemParams({
    required this.name,
    required this.image,
    required this.variants,
    required this.sellingPrice,
    required this.remainingQuantity,
  });

  AddMenuItemParams copyWith({
    String? name,
    String? image,
    List<String>? variants,
    int? sellingPrice,
    int? remainingQuantity,
  }) {
    return AddMenuItemParams(
      name: name ?? this.name,
      image: image ?? this.image,
      variants: variants ?? this.variants,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
    );
  }

  @override
  List<Object?> get props =>
      [name, image, variants, sellingPrice, remainingQuantity];
}

class UpdateMenuItemParams extends Equatable {
  final String id;
  final String name;
  final String image;
  final List<String> variants;
  final int sellingPrice;
  final int remainingQuantity;

  const UpdateMenuItemParams({
    required this.id,
    required this.name,
    required this.image,
    required this.variants,
    required this.sellingPrice,
    required this.remainingQuantity,
  });

  UpdateMenuItemParams copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? variants,
    int? sellingPrice,
    int? remainingQuantity,
  }) {
    return UpdateMenuItemParams(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      variants: variants ?? this.variants,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, image, variants, sellingPrice, remainingQuantity];
}

class SetMenuItemVisibilityParams extends Equatable {
  final String id;
  final bool isVisible;

  const SetMenuItemVisibilityParams({
    required this.id,
    required this.isVisible,
  });

  @override
  List<Object?> get props => [id, isVisible];
}
