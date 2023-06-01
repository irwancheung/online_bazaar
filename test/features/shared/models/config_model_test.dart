import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/config_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/config.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_config.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_config.dart';

import '../../../helpers.dart';

void main() {
  group('ConfigModel', () {
    test('should be a subclass of Config entity.', () {
      // Arrange
      const tConfigModel = ConfigModel(
        event: EventConfig(name: 'name', pickupNote: 'pickupNote'),
        foodOrder: FoodOrderConfig(orderNumberPrefix: 'orderNumberPrefix'),
        payment: PaymentConfig(
          transferTo: 'transferTo',
          transferNoteFormat: 'transferNoteFormat',
          sendTransferProofTo: 'sendTransferProofTo',
        ),
      );

      // Assert
      expect(tConfigModel, isA<Config>());
    });

    test('fromJson() should return ConfigModel.', () async {
      // Arrange
      final tConfigJsonStr = fixture('config.json');

      // Act
      final result = ConfigModel.fromJson(tConfigJsonStr);

      // Assert
      expect(result, isA<ConfigModel>());
    });
  });
}
