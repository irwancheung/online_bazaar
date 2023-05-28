import 'dart:convert';

import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.email,
    required super.name,
    required super.chaitya,
    required super.phone,
    required super.address,
    super.createdAt,
    super.updatedAt,
  });

  factory CustomerModel.fromSetCustomerParams(SetCustomerParams params) {
    final now = DateTime.now();

    return CustomerModel(
      id: now.millisecondsSinceEpoch.toString(),
      email: params.email,
      name: params.name,
      chaitya: params.chaitya,
      phone: params.phone,
      address: params.address,
      createdAt: now,
      updatedAt: now,
    );
  }

  CustomerModel copyWith({
    String? id,
    String? email,
    String? name,
    String? chaitya,
    String? phone,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      chaitya: chaitya ?? this.chaitya,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CustomerModel.newCustomer() {
    final now = DateTime.now();

    return CustomerModel(
      id: now.millisecondsSinceEpoch.toString(),
      email: '',
      name: '',
      chaitya: '',
      phone: '',
      address: '',
      createdAt: now,
    );
  }

  factory CustomerModel.fromEntity(Customer customer) {
    return CustomerModel(
      id: customer.id,
      email: customer.email,
      name: customer.name,
      chaitya: customer.chaitya,
      phone: customer.phone,
      address: customer.address,
      createdAt: customer.createdAt,
      updatedAt: customer.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'chaitya': chaitya,
      'phone': phone,
      'address': address,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      chaitya: map['chaitya'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
