import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/payment_setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

void main() {
  group('PaymentSettingModel', () {
    test('should be a subclass of PaymentSetting entity.', () {
      // Arrange
      const tPaymentSettingModel = PaymentSettingModel(
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      );

      // Assert
      expect(tPaymentSettingModel, isA<PaymentSetting>());
    });
  });
}
