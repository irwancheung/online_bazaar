import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/payment_config.dart';

class PaymentConfigModel extends PaymentConfig {
  const PaymentConfigModel({
    required super.transferTo,
    required super.transferNoteFormat,
    required super.sendTransferProofTo,
  });

  factory PaymentConfigModel.fromEntity(PaymentConfig paymentConfig) {
    return PaymentConfigModel(
      transferTo: paymentConfig.transferTo,
      transferNoteFormat: paymentConfig.transferNoteFormat,
      sendTransferProofTo: paymentConfig.sendTransferProofTo,
    );
  }

  PaymentConfig copyWith({
    String? transferTo,
    String? transferNoteFormat,
    String? sendTransferProofTo,
  }) {
    return PaymentConfig(
      transferTo: transferTo ?? this.transferTo,
      transferNoteFormat: transferNoteFormat ?? this.transferNoteFormat,
      sendTransferProofTo: sendTransferProofTo ?? this.sendTransferProofTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transferTo': transferTo,
      'transferNoteFormat': transferNoteFormat,
      'sendTransferProofTo': sendTransferProofTo,
    };
  }

  factory PaymentConfigModel.fromMap(Map<String, dynamic> map) {
    return PaymentConfigModel(
      transferTo: map['transferTo'] as String,
      transferNoteFormat: map['transferNoteFormat'] as String,
      sendTransferProofTo: map['sendTransferProofTo'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PaymentConfigModel.fromJson(String source) =>
      PaymentConfigModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
