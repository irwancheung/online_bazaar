import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

import '../../../../helpers.dart';
import 'admin_food_order_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdminFoodOrderRepository>()])
void main() {
  initHelpersTest();

  late MockAdminFoodOrderRepository mockRepository;
  late AdminFoodOrderCubit cubit;

  setUp(() {
    mockRepository = MockAdminFoodOrderRepository();
    cubit = AdminFoodOrderCubit(repository: mockRepository);
  });

  group('AdminFoodOrderCubit', () {
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

    final tFoodOrders = [tFoodOrder];

    test('initial state should be AdminFoodOrderState.', () {
      expect(cubit.state, const AdminFoodOrderState(foodOrders: []));
    });

    group('getFoodOrders()', () {
      test('should call repository.getFoodOrders() once.', () async {
        // Arrange
        when(mockRepository.getFoodOrders())
            .thenAnswer((_) => Stream.value(tFoodOrders));

        // Act
        cubit.getFoodOrders();
        await untilCalled(mockRepository.getFoodOrders());

        // Assert
        verify(mockRepository.getFoodOrders()).called(1);
      });

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [GetFoodOrdersLoadingState, GetFoodOrdersSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.getFoodOrders())
              .thenAnswer((_) => Stream.value(tFoodOrders));
        },
        build: () => cubit,
        act: (cubit) => cubit.getFoodOrders(),
        expect: () => <AdminFoodOrderState>[
          const GetFoodOrdersLoadingState(foodOrders: []),
          GetFoodOrdersSuccessState(foodOrders: tFoodOrders),
        ],
      );
    });

    group('updateFoodOrderStatus()', () {
      const tUpdateParams = UpdateFoodOrderStatusParams(
        id: 'id',
        status: OrderStatus.completed,
      );

      test('should call repository.updateFoodOrderStatus() once.', () async {
        // Arrange
        when(mockRepository.updateFoodOrderStatus(any))
            .thenAnswer((_) async => tFoodOrder);

        // Act
        cubit.updateFoodOrderStatus(tUpdateParams);
        await untilCalled(mockRepository.updateFoodOrderStatus(any));

        // Assert
        verify(mockRepository.updateFoodOrderStatus(any)).called(1);
      });

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [UpdateFoodOrderStatusLoadingState, UpdateFoodOrderStatusSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.updateFoodOrderStatus(any))
              .thenAnswer((_) async => tFoodOrder);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateFoodOrderStatus(tUpdateParams),
        expect: () => <AdminFoodOrderState>[
          const UpdateFoodOrderStatusLoadingState(foodOrders: []),
          UpdateFoodOrderStatusSuccessState(
            foodOrder: tFoodOrder,
            foodOrders: const [],
          ),
        ],
      );

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [UpdateFoodOrderStatusLoadingState, UpdateFoodOrderStatusFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.updateFoodOrderStatus(any)).thenThrow(
            const UpdateFoodOrderStatusException(''),
          );
        },
        build: () => cubit,
        act: (cubit) => cubit.updateFoodOrderStatus(tUpdateParams),
        expect: () => <AdminFoodOrderState>[
          const UpdateFoodOrderStatusLoadingState(foodOrders: []),
          const UpdateFoodOrderStatusFailureState(
            foodOrders: [],
            errorMessage: '',
          ),
        ],
      );
    });

    group('exportFoodOrdersToSheetFile()', () {
      const tExportParams = ExportFoodOrdersToSheetFileParams(
        foodOrders: [],
      );

      test('should call repository.exportFoodOrdersToSheetFile() once.',
          () async {
        // Arrange
        when(mockRepository.exportFoodOrdersToSheetFile(any))
            .thenAnswer((_) async {});

        // Act
        cubit.exportFoodOrdersToSheetFile(tExportParams);
        await untilCalled(mockRepository.exportFoodOrdersToSheetFile(any));

        // Assert
        verify(mockRepository.exportFoodOrdersToSheetFile(any)).called(1);
      });

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [ExportFoodOrdersToSheetFileLoadingState, ExportFoodOrdersToSheetFileSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.exportFoodOrdersToSheetFile(any))
              .thenAnswer((_) async {});
        },
        build: () => cubit,
        act: (cubit) => cubit.exportFoodOrdersToSheetFile(tExportParams),
        expect: () => <AdminFoodOrderState>[
          const ExportFoodOrdersToSheetFileLoadingState(foodOrders: []),
          const ExportFoodOrdersToSheetFileSuccessState(foodOrders: []),
        ],
      );

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [ExportFoodOrdersToSheetFileLoadingState, ExportFoodOrdersToSheetFileFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.exportFoodOrdersToSheetFile(any)).thenThrow(
            const UpdateFoodOrderStatusException(''),
          );
        },
        build: () => cubit,
        act: (cubit) => cubit.exportFoodOrdersToSheetFile(tExportParams),
        expect: () => <AdminFoodOrderState>[
          const ExportFoodOrdersToSheetFileLoadingState(foodOrders: []),
          const ExportFoodOrdersToSheetFileFailureState(
            foodOrders: [],
            errorMessage: '',
          ),
        ],
      );
    });

    group('updateAdminNote()', () {
      const note = 'note';
      const tUpdateParams = UpdateAdminNoteParams(
        id: 'id',
        adminNote: note,
      );

      test('should call repository.updateAdminNote() once.', () async {
        // Arrange
        when(mockRepository.updateAdminNote(any))
            .thenAnswer((_) async => tFoodOrder);

        // Act
        cubit.updateAdminNote(tUpdateParams);
        await untilCalled(mockRepository.updateAdminNote(any));

        // Assert
        verify(mockRepository.updateAdminNote(any)).called(1);
      });

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [UpdateAdminNoteLoadingState, UpdateAdminNoteSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.updateAdminNote(any))
              .thenAnswer((_) async => tFoodOrder);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateAdminNote(tUpdateParams),
        expect: () => <AdminFoodOrderState>[
          const UpdateAdminNoteLoadingState(foodOrders: []),
          UpdateAdminNoteSuccessState(
            foodOrder: tFoodOrder,
            foodOrders: const [],
          ),
        ],
      );

      blocTest<AdminFoodOrderCubit, AdminFoodOrderState>(
        'emits [UpdateAdminNoteLoadingState, UpdateAdminNoteFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.updateAdminNote(any)).thenThrow(
            const UpdateAdminNoteException(''),
          );
        },
        build: () => cubit,
        act: (cubit) => cubit.updateAdminNote(tUpdateParams),
        expect: () => <AdminFoodOrderState>[
          const UpdateAdminNoteLoadingState(foodOrders: []),
          const UpdateAdminNoteFailureState(
            foodOrders: [],
            errorMessage: '',
          ),
        ],
      );
    });
  });
}
