import 'package:equatable/equatable.dart';

class PaymentConfig extends Equatable {
  final String transferTo;
  final String transferNoteFormat;
  final String sendTransferProofTo;

  const PaymentConfig({
    required this.transferTo,
    required this.transferNoteFormat,
    required this.sendTransferProofTo,
  });

  @override
  List<Object?> get props => [
        transferTo,
        transferNoteFormat,
        sendTransferProofTo,
      ];
}
