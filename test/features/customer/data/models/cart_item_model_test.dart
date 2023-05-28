import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/customer/data/models/cart_item_model.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

void main() {
  group('CartItemModel', () {
    test('should be a subclass of CartItem entity.', () {
      // Arrange
      const tCartItemModel = CartItemModel(
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
        variant: 'variant',
        quantity: 0,
        note: 'note',
      );

      // assert
      expect(tCartItemModel, isA<CartItem>());
    });
  });
}
