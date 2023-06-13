import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';

class Payment extends Equatable {
  final PaymentType type;
  final String transferTo;
  final String transferNoteFormat;
  final String sendTransferProofTo;

  const Payment({
    required this.type,
    required this.transferTo,
    required this.transferNoteFormat,
    required this.sendTransferProofTo,
  });

  @override
  List<Object?> get props => [
        type,
        transferTo,
        transferNoteFormat,
        sendTransferProofTo,
      ];
}
