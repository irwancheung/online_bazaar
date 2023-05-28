import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String image;
  final List<String> variants;
  final int sellingPrice;
  final int soldQuantity;
  final int remainingQuantity;
  final bool isVisible;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MenuItem({
    required this.id,
    required this.name,
    required this.image,
    required this.variants,
    required this.sellingPrice,
    required this.soldQuantity,
    required this.remainingQuantity,
    required this.isVisible,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        variants,
        sellingPrice,
        soldQuantity,
        remainingQuantity,
        isVisible,
        createdAt,
        updatedAt,
      ];
}
