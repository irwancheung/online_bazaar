import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_setting_data_source.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_setting_repository_impl.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import 'customer_setting_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerSettingDataSource>()])
void main() {
  late MockCustomerSettingDataSource mockDataSource;
  late CustomerSettingRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCustomerSettingDataSource();
    repository = CustomerSettingRepositoryImpl(
      dataSource: mockDataSource,
    );
  });

  group('CustomerSettingRepositoryImpl', () {
    group('getSetting()', () {
      test('should return Stream<Setting>.', () async {
        // Arrange
        const tSettingModel = SettingModel(
          id: 'id',
          event: EventSetting(name: 'name', pickupNote: 'pickupNote'),
          foodOrder: FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
          payment: PaymentSetting(
            transferTo: 'transferTo',
            transferNoteFormat: 'transferNoteFormat',
            sendTransferProofTo: 'sendTransferProofTo',
          ),
        );

        when(mockDataSource.getSetting())
            .thenAnswer((_) => Stream.value(tSettingModel));

        // Act
        final result = repository.getSetting();

        // Assert
        verify(mockDataSource.getSetting()).called(1);
        expect(result, isA<Stream<Setting>>());
      });
    });
  });
}
