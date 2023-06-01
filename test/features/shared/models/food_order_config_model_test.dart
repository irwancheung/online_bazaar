import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_config_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_config.dart';

void main() {
  group('FoodOrderConfigModel', () {
    test('should be a subclass of FoodOrderConfig entity.', () {
      // Arrange
      const tFoodOrderConfigModel =
          FoodOrderConfigModel(orderNumberPrefix: 'orderNumberPrefix');

      // Assert
      expect(tFoodOrderConfigModel, isA<FoodOrderConfig>());
    });
  });
}
