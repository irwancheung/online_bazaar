import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

void main() {
  group('FoodOrderItemModel', () {
    test('should be a subclass of FoodOrderItem entity.', () {
      // Arrange
      const tFoodOrderItemModel = FoodOrderItemModel(
        id: 'id',
        item: MenuItem(
          id: 'id',
          name: 'name',
          image: 'image',
          variants: [],
          sellingPrice: 0,
          soldQuantity: 0,
          remainingQuantity: 0,
          isVisible: true,
        ),
        name: 'name',
        image: 'image',
        variant: 'variant',
        quantity: 0,
        price: 0,
        note: 'note',
      );

      // assert
      expect(tFoodOrderItemModel, isA<FoodOrderItem>());
    });
  });
}
