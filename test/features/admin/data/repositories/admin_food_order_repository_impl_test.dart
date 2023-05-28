import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';
import 'package:online_bazaar/core/generators/sheet_generator.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_food_order_datasource.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_food_order_repository_impl.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

import 'admin_food_order_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfo>(),
  MockSpec<AdminFoodOrderDataSource>(),
  MockSpec<SheetGenerator>(),
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockAdminFoodOrderDataSource mockDataSource;
  late MockSheetGenerator mockSheetGenerator;
  late AdminFoodOrderRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockAdminFoodOrderDataSource();
    mockSheetGenerator = MockSheetGenerator();
    repository = AdminFoodOrderRepositoryImpl(
      networkInfo: mockNetworkInfo,
      dataSource: mockDataSource,
      sheetGenerator: mockSheetGenerator,
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

  group('AdminFoodOrderRepositoryImpl', () {
    group('getFoorOrders()', () {
      test('should return Stream<List<FoodOrder>>', () async {
        // Arrange
        when(mockDataSource.getFoodOrders())
            .thenAnswer((_) => Stream.value([]));

        // Act
        final result = repository.getFoodOrders();

        // Assert
        verify(mockDataSource.getFoodOrders()).called(1);
        expect(result, isA<Stream<List<FoodOrder>>>());
      });
    });

    group('updateFoodOrderStatus()', () {
      const tUpdateParams =
          UpdateFoodOrderStatusParams(id: 'id', status: OrderStatus.completed);

      final tFoodOrderModel = FoodOrderModel(
        id: 'id',
        event: Event(
          id: 'id',
          title: 'title',
          pickupNote: 'pickupNote',
          startAt: DateTime.utc(0),
          endAt: DateTime.utc(0),
        ),
        customer: const Customer(
          id: 'id',
          email: 'email',
          name: 'name',
          chaitya: 'chaitya',
          phone: 'phone',
          address: 'address',
        ),
        type: OrderType.delivery,
        paymentType: PaymentType.bankTransfer,
        status: OrderStatus.completed,
        items: const [],
        note: 'note',
        totalQuantity: 0,
        subTotalPrice: 0,
        deliveryCharge: 0,
        additionalCharge: 0,
        discount: 0,
        totalPrice: 0,
      );

      runInternetDisconnectedTests(
        () => repository.updateFoodOrderStatus(tUpdateParams),
      );

      test('should return FoodOrder when dataSource is successful.', () async {
        // Arrange
        setInternetConnected();
        when(
          mockDataSource.updateFoodOrderStatus(any),
        ).thenAnswer((_) async => tFoodOrderModel);

        // Act
        final result = await repository.updateFoodOrderStatus(tUpdateParams);

        // Assert
        verify(mockDataSource.updateFoodOrderStatus(tUpdateParams)).called(1);
        expect(result, equals(tFoodOrderModel));
      });

      test(
          'should throw UpdateFoodOrderStatusException when dataSource is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(
          mockDataSource.updateFoodOrderStatus(any),
        ).thenThrow(const UpdateFoodOrderStatusException());

        // Act
        final call = repository.updateFoodOrderStatus;

        // Assert
        expect(
          call(tUpdateParams),
          throwsA(isA<UpdateFoodOrderStatusException>()),
        );
      });
    });

    group('exportFoodOrdersToSheetFile()', () {
      //TODO: how to implement test?
    });
  });
}
