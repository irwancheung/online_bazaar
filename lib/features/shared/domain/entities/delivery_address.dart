import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DeliveryAddress({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
        createdAt,
        updatedAt,
      ];
}
