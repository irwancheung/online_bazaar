import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class CartItem extends Equatable {
  final String id;
  final MenuItem item;
  final String variant;
  final int quantity;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartItem({
    required this.id,
    required this.item,
    required this.variant,
    required this.quantity,
    required this.note,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        item,
        variant,
        quantity,
        note,
        createdAt,
        updatedAt,
      ];
}
