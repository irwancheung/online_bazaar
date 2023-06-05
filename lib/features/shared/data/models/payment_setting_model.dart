import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

class PaymentSettingModel extends PaymentSetting {
  const PaymentSettingModel({
    required super.transferTo,
    required super.transferNoteFormat,
    required super.sendTransferProofTo,
  });

  factory PaymentSettingModel.fromEntity(PaymentSetting paymentSetting) {
    return PaymentSettingModel(
      transferTo: paymentSetting.transferTo,
      transferNoteFormat: paymentSetting.transferNoteFormat,
      sendTransferProofTo: paymentSetting.sendTransferProofTo,
    );
  }

  PaymentSetting copyWith({
    String? transferTo,
    String? transferNoteFormat,
    String? sendTransferProofTo,
  }) {
    return PaymentSetting(
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

  factory PaymentSettingModel.fromMap(Map<String, dynamic> map) {
    return PaymentSettingModel(
      transferTo: map['transferTo'] as String,
      transferNoteFormat: map['transferNoteFormat'] as String,
      sendTransferProofTo: map['sendTransferProofTo'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PaymentSettingModel.fromJson(String source) =>
      PaymentSettingModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
