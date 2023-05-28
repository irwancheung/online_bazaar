import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/customer_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

void main() {
  group('CustomerModel', () {
    test('should be a subclass of Customer entity.', () {
      // Arrange
      const tCustomerModel = CustomerModel(
        id: 'id',
        name: 'name',
        email: 'email',
        chaitya: 'chaitya',
        phone: 'phone',
        address: 'address',
      );

      // assert
      expect(tCustomerModel, isA<Customer>());
    });
  });
}
