import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/payment_config_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_config.dart';

void main() {
  group('PaymentConfigModel', () {
    test('should be a subclass of PaymentConfig entity.', () {
      // Arrange
      const tPaymentConfigModel = PaymentConfigModel(
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      );

      // Assert
      expect(tPaymentConfigModel, isA<PaymentConfig>());
    });
  });
}
