import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import '../../../helpers.dart';

void main() {
  group('ConfigModel', () {
    test('should be a subclass of Setting entity.', () {
      // Arrange
      const tConfigModel = SettingModel(
        event: EventSetting(name: 'name', pickupNote: 'pickupNote'),
        foodOrder: FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
        payment: PaymentSetting(
          transferTo: 'transferTo',
          transferNoteFormat: 'transferNoteFormat',
          sendTransferProofTo: 'sendTransferProofTo',
        ),
      );

      // Assert
      expect(tConfigModel, isA<Setting>());
    });

    test('fromJson() should return SettingModel.', () async {
      // Arrange
      final tSettingJsonStr = fixture('setting.json');

      // Act
      final result = SettingModel.fromJson(tSettingJsonStr);

      // Assert
      expect(result, isA<SettingModel>());
    });
  });
}
