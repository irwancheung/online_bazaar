import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_menu_data_source.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';

import '../../../../helpers.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CustomerMenuDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = CustomerMenuDataSource(firestore: fakeFirestore);
  });

  group('CustomerMenuDataSource', () {
    group('getMenuItems()', () {
      test('should return Stream<List<MenuItemModel>>.', () async {
        // Arrange
        await fakeFirestore
            .collection('menu_items')
            .add(jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>);

        // Act
        final result = dataSource.getMenuItems();

        // Assert
        expect(result, isA<Stream<List<MenuItemModel>>>());
      });
    });
  });
}
