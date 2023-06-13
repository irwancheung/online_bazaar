import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

import '../../../../helpers.dart';
import 'customer_food_order_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerFoodOrderRepository>()])
void main() {
  initHelpersTest();

  late MockCustomerFoodOrderRepository mockRepository;
  late CustomerFoodOrderCubit cubit;

  setUp(() {
    mockRepository = MockCustomerFoodOrderRepository();
    cubit = CustomerFoodOrderCubit(
      repository: mockRepository,
    );
  });

  group('CustomerFoodOrderCubit', () {
    test('initial state should be CustomerFoodOrderState.', () {
      expect(cubit.state, const CustomerFoodOrderState());
    });

    group('downloadFoodOrderReceipt()', () {
      final tFoodOrder = FoodOrder(
        id: 'id',
        event: Event(
          name: 'name',
          pickupNote: 'pickupNote',
          startAt: DateTime.utc(0),
          endAt: DateTime.utc(0),
        ),
        payment: const Payment(
          type: PaymentType.bankTransfer,
          transferTo: 'transferTo',
          transferNoteFormat: 'transferNoteFormat',
          sendTransferProofTo: 'sendTransferProofTo',
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

      final tParams = DownloadFoodOrderReceiptParams(foodOrder: tFoodOrder);

      test('should call repository.downloadFoodOrderReceipt() once.', () async {
        // Assert
        when(mockRepository.downloadFoodOrderReceipt(any))
            .thenAnswer((_) async {});

        // Act
        cubit.downloadFoodOrderReceipt(tParams);
        await untilCalled(mockRepository.downloadFoodOrderReceipt(any));

        // Assert
        verify(mockRepository.downloadFoodOrderReceipt(any)).called(1);
      });

      blocTest<CustomerFoodOrderCubit, CustomerFoodOrderState>(
        'emits [DownloadFoorOrderReceiptLoadingState, DownloadFoorOrderReceiptSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.downloadFoodOrderReceipt(any))
              .thenAnswer((_) async {});
        },
        build: () => cubit,
        act: (cubit) => cubit.downloadFoodOrderReceipt(tParams),
        expect: () => <CustomerFoodOrderState>[
          const DownloadFoorOrderReceiptLoadingState(),
          const DownloadFoorOrderReceiptSuccessState(),
        ],
      );

      blocTest<CustomerFoodOrderCubit, CustomerFoodOrderState>(
        'emits [DownloadFoorOrderReceiptLoadingState, DownloadFoorOrderReceiptFailureState] when repo is successful.',
        setUp: () {
          when(mockRepository.downloadFoodOrderReceipt(any))
              .thenThrow(const DownloadFoodOrderReceiptException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.downloadFoodOrderReceipt(tParams),
        expect: () => <CustomerFoodOrderState>[
          const DownloadFoorOrderReceiptLoadingState(),
          const DownloadFoorOrderReceiptFailureState(errorMessage: ''),
        ],
      );
    });
  });
}
