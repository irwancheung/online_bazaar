import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_setting_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_setting_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

import '../../../../helpers.dart';
import 'customer_setting_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerSettingRepository>()])
void main() {
  initHelpersTest();

  late MockCustomerSettingRepository mockRepository;
  late CustomerSettingCubit cubit;

  setUp(() {
    mockRepository = MockCustomerSettingRepository();
    cubit = CustomerSettingCubit(repository: mockRepository);
  });

  group('CustomerSettingCubit', () {
    const tSetting = Setting(
      id: 'id',
      event: EventSetting(name: 'name', pickupNote: 'pickupNote'),
      foodOrder: FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
      payment: PaymentSetting(
        transferTo: 'transferTo',
        transferNoteFormat: 'transferNoteFormat',
        sendTransferProofTo: 'sendTransferProofTo',
      ),
    );

    test('initial state should be CustomerSettingState.', () {
      expect(cubit.state, const CustomerSettingState());
    });

    group('getSetting()', () {
      test('should call repository.getSetting() once.', () async {
        // Arrange
        when(mockRepository.getSetting())
            .thenAnswer((_) => Stream.value(tSetting));

        // Act
        cubit.getSetting();
        await untilCalled(mockRepository.getSetting());

        // Assert
        verify(mockRepository.getSetting()).called(1);
      });

      blocTest<CustomerSettingCubit, CustomerSettingState>(
        'emits [GetSettingLoadingState, GetSettingSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.getSetting())
              .thenAnswer((_) => Stream.value(tSetting));
        },
        build: () => cubit,
        act: (cubit) => cubit.getSetting(),
        expect: () => const <CustomerSettingState>[
          GetSettingLoadingState(setting: null),
          GetSettingSuccessState(setting: tSetting),
        ],
      );
    });
  });
}
