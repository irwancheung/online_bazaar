import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/menu_exception.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_menu_data_source.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_menu_repository_impl.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

import '../../../../helpers.dart';
import 'admin_menu_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<AdminMenuDataSource>(),
])
void main() {
  initHelpersTest();

  late MockNetworkInfo mockNetworkInfo;
  late MockAdminMenuDataSource mockDataSource;
  late AdminMenuRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockAdminMenuDataSource();
    repository = AdminMenuRepositoryImpl(
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

  group('AdminMenuRepositoryImpl', () {
    const tItemModel = MenuItemModel(
      id: 'id',
      name: 'name',
      image: 'image',
      variants: [],
      sellingPrice: 0,
      soldQuantity: 0,
      remainingQuantity: 0,
      isVisible: true,
    );

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

    group('addMenuItem()', () {
      const tAddMenuItemParams = AddMenuItemParams(
        name: 'name',
        image: 'image',
        variants: [],
        sellingPrice: 0,
        remainingQuantity: 0,
      );

      runInternetDisconnectedTests(
        () => repository.addMenuItem(tAddMenuItemParams),
      );

      test('should return MenuItem when dataSource is successfull.', () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.addMenuItem(any))
            .thenAnswer((_) async => tItemModel);

        // Act
        final result = await repository.addMenuItem(tAddMenuItemParams);

        // Assert
        verify(mockDataSource.addMenuItem(any)).called(1);
        expect(result, isA<MenuItem>());
      });

      test('should throw AddMenuItemException if when dataSource is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.addMenuItem(any))
            .thenThrow(const AddMenuItemException());

        // Act
        final call = repository.addMenuItem;

        // Assert
        expect(
          call(tAddMenuItemParams),
          throwsA(isA<AddMenuItemException>()),
        );
      });
    });

    group('updateMenuItem()', () {
      const tUpdateMenuItemParams = UpdateMenuItemParams(
        id: 'id',
        name: 'name',
        image: 'image',
        variants: [],
        sellingPrice: 0,
        remainingQuantity: 0,
      );

      runInternetDisconnectedTests(
        () => repository.updateMenuItem(tUpdateMenuItemParams),
      );

      test('should return MenuItem when dataSource is successful.', () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.updateMenuItem(any))
            .thenAnswer((_) async => tItemModel);

        when(mockDataSource.uploadMenuItemImage(any))
            .thenAnswer((_) async => 'image');

        // Act
        final result = await repository.updateMenuItem(tUpdateMenuItemParams);

        // Assert
        verify(mockDataSource.updateMenuItem(tUpdateMenuItemParams)).called(1);
        expect(result, isA<MenuItem>());
      });

      test('should throw UpdateMenuItemException when dataSource is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.updateMenuItem(any))
            .thenThrow(const UpdateMenuItemException());

        // Act
        final call = repository.updateMenuItem;

        // Assert
        expect(
          call(tUpdateMenuItemParams),
          throwsA(isA<UpdateMenuItemException>()),
        );
      });
    });

    group('setMenuItemVisibility', () {
      const tSetMenuItemVisibilityParams = SetMenuItemVisibilityParams(
        id: 'id',
        isVisible: true,
      );

      runInternetDisconnectedTests(
        () => repository.setMenuItemVisibility(tSetMenuItemVisibilityParams),
      );

      test('should return MenuItem when dataSource is successful.', () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.setMenuItemVisibility(any))
            .thenAnswer((_) async => tItemModel);

        // Act
        final result = await repository
            .setMenuItemVisibility(tSetMenuItemVisibilityParams);

        // Assert
        verify(mockDataSource.setMenuItemVisibility(any)).called(1);
        expect(result, isA<MenuItem>());
      });

      test(
          'should throw SetMenuItemVisibilityException when dataSource is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(mockDataSource.setMenuItemVisibility(any))
            .thenThrow(const SetMenuItemVisibilityException());

        // Act
        final call = repository.setMenuItemVisibility;

        // Assert
        expect(
          call(tSetMenuItemVisibilityParams),
          throwsA(isA<SetMenuItemVisibilityException>()),
        );
      });
    });
  });
}
