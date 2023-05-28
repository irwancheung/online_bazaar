import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

void main() {
  late CustomerRepositoryImpl repository;

  setUp(() => repository = CustomerRepositoryImpl());

  group('CustomerRepositoryImpl', () {
    group('setCustomer()', () {
      test('should return Customer.', () async {
        // Act
        final result = await repository.setCustomer(
          const SetCustomerParams(
            email: 'email',
            name: 'name',
            chaitya: 'chaitya',
            phone: 'phone',
            address: 'address',
          ),
        );

        // Assert
        expect(result, isA<Customer>());
      });
    });
  });
}
