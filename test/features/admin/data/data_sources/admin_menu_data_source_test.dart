import 'dart:convert';
import 'dart:io';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_menu_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';

import '../../../../helpers.dart';

void main() {
  initHelpersTest();

  late FakeFirebaseFirestore fakeFirestore;
  late MockFirebaseStorage mockStorage;
  late AdminMenuDataSource dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockStorage = MockFirebaseStorage();
    dataSource = AdminMenuDataSource(
      firestore: fakeFirestore,
      storage: mockStorage,
    );
  });

  group('AdminMenuDataSource', () {
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

    group('addMenuItem()', () {
      test('should return MenuItemModel with Firestore auto generated ID.',
          () async {
        // Arrange
        const tAddMenuItemParams = AddMenuItemParams(
          name: 'name',
          image: 'image',
          variants: [],
          sellingPrice: 0,
          remainingQuantity: 0,
        );

        final tItemMap =
            jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>;
        final tReference =
            await fakeFirestore.collection('menu_items').add(tItemMap);

        // Act
        final result = await dataSource.addMenuItem(tAddMenuItemParams);

        expect(result, isA<MenuItemModel>());
        expect(result.id, isNot(tReference.id));
      });
    });

    group('updateMenuItem()', () {
      test('should return MenuItemModel from Firestore.', () async {
        // Arrange
        final tItemMap =
            jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>;
        final tDocRef =
            await fakeFirestore.collection('menu_items').add(tItemMap);

        final tUpdatedItemMap = {
          'id': tDocRef.id,
          'name': 'Updated Name',
          ...tItemMap,
        };

        final tUpdatedItem = MenuItemModel.fromMap(tUpdatedItemMap);

        // Act
        final result = await dataSource.updateMenuItem(
          UpdateMenuItemParams(
            id: tDocRef.id,
            name: tUpdatedItem.name,
            image: tUpdatedItem.image,
            variants: tUpdatedItem.variants,
            sellingPrice: tUpdatedItem.sellingPrice,
            remainingQuantity: tUpdatedItem.remainingQuantity,
          ),
        );

        // Assert
        expect(result, isA<MenuItemModel>());
        expect(result.name, tUpdatedItem.name);
      });
    });

    group('setMenuItemVisibility()', () {
      test('should return MenuItemModel from Firestore.', () async {
        // Arrange
        final tItemMap =
            jsonDecode(fixture('menu_item.json')) as Map<String, dynamic>;
        final tReference =
            await fakeFirestore.collection('menu_items').add(tItemMap);

        final tUpdatedItemMap = {
          ...tItemMap,
          'hidden': true,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        };

        final tUpdatedItem = MenuItemModel.fromMap(tUpdatedItemMap);

        // Act
        final result = await dataSource.setMenuItemVisibility(
          SetMenuItemVisibilityParams(
            id: tReference.id,
            isVisible: true,
          ),
        );

        // Assert
        expect(result, isA<MenuItemModel>());
        expect(result.isVisible, tUpdatedItem.isVisible);
      });
    });

    group('uploadMenuItemImage()', () {
      test('should return String of file url from Storage.', () async {
        // Arrange
        final tFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        const tFilePath = 'test/mock_data/image.jpg';
        final tStorageRef = mockStorage.ref().child('menu-items/$tFileName');

        // Act
        await tStorageRef.putFile(File(tFilePath));
        final result = await dataSource.uploadMenuItemImage(tFilePath);

        // Assert
        expect(result, isA<String>());
      });
    });
  });
}
