import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/event_setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';

void main() {
  group('EventSettingModel', () {
    test('should be a subclass of EventSetting entity.', () {
      // Arrange
      const tEventSettingModel =
          EventSettingModel(name: 'name', pickupNote: 'pickupNote');

      // Assert
      expect(tEventSettingModel, isA<EventSetting>());
    });
  });
}
