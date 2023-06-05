import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';

void main() {
  group('FoodOrderSettingModel', () {
    test('should be a subclass of FoodOrderSetting entity.', () {
      // Arrange
      const tFoodOrderSettingModel =
          FoodOrderSettingModel(orderNumberPrefix: 'orderNumberPrefix');

      // Assert
      expect(tFoodOrderSettingModel, isA<FoodOrderSetting>());
    });
  });
}
