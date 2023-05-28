import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Admin({
    required this.id,
    required this.email,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, email, name, createdAt, updatedAt];
}
