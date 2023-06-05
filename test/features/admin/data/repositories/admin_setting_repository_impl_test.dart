import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_setting_data_source.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_setting_repository_impl.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

import '../../../../helpers.dart';
import 'admin_setting_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<AdminSettingDataSource>(),
])
void main() {
  initHelpersTest();

  late MockNetworkInfo mockNetworkInfo;
  late MockAdminSettingDataSource mockDataSource;
  late AdminSettingRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockAdminSettingDataSource();
    repository = AdminSettingRepositoryImpl(
      networkInfo: mockNetworkInfo,
      dataSource: mockDataSource,
    );
  });

  void setInternetConnected() {
    when(mockNetworkInfo.checkConnection()).thenAnswer((_) async {});
  }

  void setInternetDisconnected() {
    when(mockNetworkInfo.checkConnection()).thenThrow(NetworkException());
  }

  void runInternetDisconnectedTests(Function() method) {
    test(
        'should check for network connection and throw NetworkException when there is no internet connection.',
        () async {
      // Arrange
      setInternetDisconnected();

      // Assert
      expect(method, throwsA(isA<NetworkException>()));
    });
  }

  group('AdminSettingRepositoryImpl', () {
    const tSettingModel = SettingModel(
      event: EventSetting(name: 'name', pickupNote: 'pickupNote'),
      foodOrder: FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
      payment: PaymentSetting(
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      ),
    );

    group('getSetting()', () {
      runInternetDisconnectedTests(() => repository.getSetting());

      test('should return Setting when dataSource is successful.', () async {
        // Arrange
        setInternetConnected();
        when(mockDataSource.getSetting())
            .thenAnswer((_) async => tSettingModel);

        // Act
        final result = await repository.getSetting();

        // Assert
        expect(result, tSettingModel);
      });

      test('should throw GetSettingException when dataSource is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.getSetting())
            .thenThrow(const GetSettingException(''));

        // Act
        final call = repository.getSetting;

        // Assert
        expect(call, throwsA(isA<GetSettingException>()));
      });
    });

    group('updateSetting()', () {
      final tParams = UpdateSettingsParams(
        eventName: 'eventName',
        eventPickupNote: 'eventPickupNote',
        eventStartAt: DateTime.utc(0),
        eventEndAt: DateTime.utc(0),
        orderNumberPrefix: 'orderNumberPrefix',
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      );

      runInternetDisconnectedTests(() => repository.updateSetting(tParams));

      test(
          'should return Setting with updated value when dataSource is successful.',
          () async {
        // Arrange
        final newTsettingModel = SettingModel.fromUpdateSettingParams(tParams);

        setInternetConnected();
        when(mockDataSource.updateSetting(tParams))
            .thenAnswer((_) async => newTsettingModel);

        // Act
        final result = await repository.updateSetting(tParams);

        // Assert
        expect(result, newTsettingModel);
      });
    });
  });
}
