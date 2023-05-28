import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_menu_data_source.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_menu_repository_impl.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

import 'customer_menu_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerMenuDataSource>()])
void main() {
  late MockCustomerMenuDataSource mockDataSource;
  late CustomerMenuRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCustomerMenuDataSource();
    repository = CustomerMenuRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  group('CustomerMenuRepositoryImpl', () {
    group('getMenuItems()', () {
      test('should return Stream<List<MenuItem>>.', () async {
        // Arrange
        when(mockDataSource.getMenuItems()).thenAnswer((_) => Stream.value([]));

        // Act
        final result = repository.getMenuItems();

        // Assert
        verify(mockDataSource.getMenuItems()).called(1);
        expect(result, isA<Stream<List<MenuItem>>>());
      });
    });
  });
}
