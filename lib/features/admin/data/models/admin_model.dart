import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';

class AdminModel extends Admin {
  const AdminModel({
    required super.id,
    required super.email,
    required super.name,
    super.createdAt,
    super.updatedAt,
  });

  factory AdminModel.fromFirebaseAuthUser(auth.User user) {
    return AdminModel(
      id: user.uid,
      email: user.email!,
      name: user.displayName ?? 'Anonymous',
      createdAt: user.metadata.creationTime,
      updatedAt: user.metadata.lastSignInTime,
    );
  }

  factory AdminModel.fromEntity(Admin admin) {
    return AdminModel(
      id: admin.id,
      email: admin.email,
      name: admin.name,
      createdAt: admin.createdAt,
      updatedAt: admin.updatedAt,
    );
  }

  AdminModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
