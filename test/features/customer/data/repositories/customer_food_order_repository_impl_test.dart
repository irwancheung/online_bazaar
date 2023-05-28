import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_food_order_repository_impl.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../helpers.dart';
import '../../../../mock_data/food_order_receipt.dart';
import 'customer_food_order_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ScreenshotController>()])
void main() {
  initHelpersTest();

  late MockScreenshotController mockScreenshotController;
  late CustomerFoodOrderRepositoryImpl repository;

  setUp(() {
    mockScreenshotController = MockScreenshotController();
    repository = CustomerFoodOrderRepositoryImpl(
      screenshotController: mockScreenshotController,
    );
  });

  group('CustomerFoodOrderRepositoryImpl', () {
    group('downloadFoodOrderReceipt()', () {
      test('should return void.', () async {
        // Act
        when(mockScreenshotController.captureFromWidget(any))
            .thenAnswer((_) async => mockFoodOrderRecipt);

        final tParams = DownloadFoodOrderReceiptParams(
          foodOrder: FoodOrder(
            id: 'Mg1tQWz3ypghckwta4RM',
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
            type: OrderType.pickup,
            paymentType: PaymentType.bankTransfer,
            status: OrderStatus.paymentPending,
            items: const [],
            note: 'note',
            totalQuantity: 0,
            subTotalPrice: 0,
            deliveryCharge: 0,
            additionalCharge: 0,
            discount: 0,
            totalPrice: 0,
          ),
        );

        final call = repository.downloadFoodOrderReceipt;

        // Assert
        expect(call(tParams), isA<Future<void>>());
      });
    });
  });
}
