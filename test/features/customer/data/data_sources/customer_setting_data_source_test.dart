import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_setting_data_source.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import '../../../../helpers.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CustomerSettingDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = CustomerSettingDataSource(firestore: fakeFirestore);
  });

  group('CustomerSettingDataSource', () {
    group('getSetting()', () {
      test('should return Stream<Setting>', () async {
        // Arrange
        await fakeFirestore
            .collection('settings')
            .add(jsonDecode(fixture('setting.json')) as Map<String, dynamic>);

        // Act
        final result = dataSource.getSetting();

        // Assert
        expect(result, isA<Stream<Setting>>());
      });
    });
  });
}
