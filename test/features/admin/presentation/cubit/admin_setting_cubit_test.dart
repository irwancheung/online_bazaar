import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order_setting.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment_setting.dart';

import '../../../../helpers.dart';
import 'admin_setting_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdminSettingRepository>()])
void main() {
  initHelpersTest();

  late MockAdminSettingRepository mockRepository;
  late AdminSettingCubit cubit;

  setUp(() {
    mockRepository = MockAdminSettingRepository();
    cubit = AdminSettingCubit(repository: mockRepository);
  });

  group('AdminSettingCubit', () {
    test('initial; state should be AdminSettingState', () async {
      expect(cubit.state, AdminSettingState(setting: cubit.state.setting));
    });

    group('getSetting()', () {
      test('should call repository.getSetting() once.', () async {
        // Arrange
        when(mockRepository.getSetting())
            .thenAnswer((_) async => cubit.state.setting);

        // Act
        cubit.getSetting();
        await untilCalled(mockRepository.getSetting());

        // Assert
        verify(mockRepository.getSetting()).called(1);
      });

      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [GetSettingLoadingState, GetSettingSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.getSetting())
              .thenAnswer((_) async => cubit.state.setting);
        },
        build: () => cubit,
        act: (cubit) => cubit.getSetting(),
        expect: () => <AdminSettingState>[
          GetSettingLoadingState(setting: cubit.state.setting),
          GetSettingSuccessState(setting: cubit.state.setting)
        ],
      );

      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [GetSettingLoadingState, GetSettingFailureState] when repo is  failed.',
        setUp: () {
          when(mockRepository.getSetting())
              .thenThrow(const GetSettingException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.getSetting(),
        expect: () => <AdminSettingState>[
          GetSettingLoadingState(setting: cubit.state.setting),
          GetSettingFailureState(setting: cubit.state.setting, errorMessage: '')
        ],
      );
    });

    group('updateSetting()', () {
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

      const tUpdatedSetting = SettingModel(
        id: 'id',
        event: EventSetting(name: 'name', pickupNote: 'pickupNote'),
        foodOrder: FoodOrderSetting(orderNumberPrefix: 'orderNumberPrefix'),
        payment: PaymentSetting(
          transferTo: 'transferTo',
          transferNoteFormat: 'transferNoteFormat',
          sendTransferProofTo: 'sendTransferProofTo',
        ),
      );

      test('should call repository.updateSetting() once.', () async {
        // Arrange
        when(mockRepository.updateSetting(any))
            .thenAnswer((_) async => cubit.state.setting);

        // Act
        cubit.updateSetting(tParams);
        await untilCalled(mockRepository.updateSetting(any));

        // Assert
        verify(mockRepository.updateSetting(any)).called(1);
      });

      late AdminSettingState preState;
      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [UpdateSettingLoadingState, UpdateSettingSuccessState] when repo is successful.',
        setUp: () {
          preState = cubit.state;

          when(mockRepository.updateSetting(any))
              .thenAnswer((_) async => tUpdatedSetting);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateSetting(tParams),
        expect: () => <AdminSettingState>[
          UpdateSettingLoadingState(setting: preState.setting),
          const UpdateSettingSuccessState(setting: tUpdatedSetting)
        ],
      );

      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [UpdateSettingLoadingState, UpdateSettingFailureState] when repo is  failed.',
        setUp: () {
          preState = cubit.state;

          when(mockRepository.updateSetting(any))
              .thenThrow(const UpdateSettingException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.updateSetting(tParams),
        expect: () => <AdminSettingState>[
          UpdateSettingLoadingState(setting: cubit.state.setting),
          UpdateSettingFailureState(
            setting: cubit.state.setting,
            errorMessage: '',
          )
        ],
      );
    });
  });
}
