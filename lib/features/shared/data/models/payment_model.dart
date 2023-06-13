import 'dart:convert';

import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/extensions/string_extension.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel({
    required super.type,
    required super.transferTo,
    required super.transferNoteFormat,
    required super.sendTransferProofTo,
  });

  // from entity
  factory PaymentModel.fromEntity(Payment payment) {
    return PaymentModel(
      type: payment.type,
      transferTo: payment.transferTo,
      transferNoteFormat: payment.transferNoteFormat,
      sendTransferProofTo: payment.sendTransferProofTo,
    );
  }

  Payment copyWith({
    PaymentType? type,
    String? transferTo,
    String? transferNoteFormat,
    String? sendTransferProofTo,
  }) {
    return Payment(
      type: type ?? this.type,
      transferTo: transferTo ?? this.transferTo,
      transferNoteFormat: transferNoteFormat ?? this.transferNoteFormat,
      sendTransferProofTo: sendTransferProofTo ?? this.sendTransferProofTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'transferTo': transferTo,
      'transferNoteFormat': transferNoteFormat,
      'sendTransferProofTo': sendTransferProofTo,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      type: (map['type'] as String).toPaymentTypeEnum(),
      transferTo: map['transferTo'] as String,
      transferNoteFormat: map['transferNoteFormat'] as String,
      sendTransferProofTo: map['sendTransferProofTo'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
