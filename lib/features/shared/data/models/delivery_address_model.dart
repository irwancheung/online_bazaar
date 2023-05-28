import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';

class DeliveryAddressModel extends DeliveryAddress {
  const DeliveryAddressModel({
    required super.id,
    required super.name,
    required super.address,
    required super.phone,
    super.createdAt,
    super.updatedAt,
  });

  factory DeliveryAddressModel.fromCheckoutForm({
    required String name,
    required String address,
    required String phone,
  }) {
    final now = DateTime.now();

    return DeliveryAddressModel(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      address: address,
      phone: phone,
      createdAt: now,
    );
  }

  factory DeliveryAddressModel.fromEntity(DeliveryAddress deliveryAddress) {
    return DeliveryAddressModel(
      id: deliveryAddress.id,
      name: deliveryAddress.name,
      address: deliveryAddress.address,
      phone: deliveryAddress.phone,
      createdAt: deliveryAddress.createdAt,
      updatedAt: deliveryAddress.updatedAt,
    );
  }

  DeliveryAddressModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeliveryAddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory DeliveryAddressModel.fromMap(Map<String, dynamic> map) {
    return DeliveryAddressModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAT'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DeliveryAddressModel.fromJson(String source) =>
      DeliveryAddressModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
