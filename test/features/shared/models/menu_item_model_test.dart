import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

void main() {
  group('MenuItemModel', () {
    test('should be a subclass of MenuItem entity.', () {
      // Arrange
      const tMenuItemModel = MenuItemModel(
        id: 'id',
        name: 'name',
        image: 'image',
        variants: [],
        sellingPrice: 0,
        soldQuantity: 0,
        remainingQuantity: 0,
        isVisible: true,
      );

      // assert
      expect(tMenuItemModel, isA<MenuItem>());
    });
  });
}
