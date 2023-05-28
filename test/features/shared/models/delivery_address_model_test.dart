import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/delivery_address_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/delivery_address.dart';

void main() {
  group('DeliveryAddressModel', () {
    test('should be a subclass of DeliveryAddress entity.', () {
      // Arrange
      const tDeliveryAddressModel = DeliveryAddressModel(
        id: 'id',
        name: 'name',
        address: 'address',
        phone: 'phone',
      );

      // assert
      expect(tDeliveryAddressModel, isA<DeliveryAddress>());
    });
  });
}
