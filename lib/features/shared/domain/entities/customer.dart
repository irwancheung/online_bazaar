import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String id;
  final String email;
  final String name;
  final String chaitya;
  final String phone;
  final String address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Customer({
    required this.id,
    required this.email,
    required this.name,
    required this.chaitya,
    required this.phone,
    required this.address,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, email, name, chaitya, phone, address, createdAt, updatedAt];
}
