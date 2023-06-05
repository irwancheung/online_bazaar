import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_setting_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';

import '../../../../helpers.dart';

void main() {
  initHelpersTest();

  late FakeFirebaseFirestore fakeFirestore;
  late AdminSettingDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = AdminSettingDataSource(firestore: fakeFirestore);
  });

  group('AdminSettingDataSource', () {
    group('getSetting()', () {
      test('should return SettingModel.', () async {
        // Arrange
        await fakeFirestore
            .collection('settings')
            .add(jsonDecode(fixture('setting.json')) as Map<String, dynamic>);

        // Act
        final result = await dataSource.getSetting();

        // Assert
        expect(result, isA<SettingModel>());
      });
    });

    group('updateSetting()', () {
      test('should return SettingModel with updated value.', () async {
        // Arrange
        await fakeFirestore
            .collection('settings')
            .add(jsonDecode(fixture('setting.json')) as Map<String, dynamic>);

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

        // Act
        final result = await dataSource.updateSetting(tParams);

        // Assert
        expect(result.event.name, tParams.eventName);
        expect(result.event.pickupNote, tParams.eventPickupNote);
        expect(result.event.startAt, tParams.eventStartAt);
        expect(result.event.endAt, tParams.eventEndAt);
        expect(result.foodOrder.orderNumberPrefix, tParams.orderNumberPrefix);
        expect(result.payment.transferTo, tParams.transferTo);
        expect(result.payment.transferNoteFormat, tParams.transferNoteFormat);
        expect(result.payment.sendTransferProofTo, tParams.sendTransferProofTo);
      });
    });
  });
}
