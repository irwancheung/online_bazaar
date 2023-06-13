import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/shared/data/models/payment_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

void main() {
  group('PaymentModel', () {
    test('should be a subclass of Payment entity.', () {
      // Arrange
      const tPaymentModel = PaymentModel(
        type: PaymentType.bankTransfer,
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      );

      // Assert
      expect(tPaymentModel, isA<Payment>());
    });
  });
}
