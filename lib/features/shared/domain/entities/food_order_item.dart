import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class FoodOrderItem extends Equatable {
  final String id;
  final MenuItem item;
  final String name;
  final String image;
  final String variant;
  final int quantity;
  final int price;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FoodOrderItem({
    required this.id,
    required this.item,
    required this.name,
    required this.image,
    required this.variant,
    required this.quantity,
    required this.price,
    required this.note,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        variant,
        quantity,
        price,
        note,
        createdAt,
        updatedAt,
      ];
}
