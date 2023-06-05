import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';

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
    final tInitialSetting = SettingModel.empty();

    test('initial; state should be AdminSettingState', () async {
      expect(cubit.state, AdminSettingState(setting: tInitialSetting));
    });

    group('getSetting()', () {
      test('should call repository.getSetting() once.', () async {
        // Arrange
        when(mockRepository.getSetting())
            .thenAnswer((_) async => tInitialSetting);

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
              .thenAnswer((_) async => tInitialSetting);
        },
        build: () => cubit,
        act: (cubit) => cubit.getSetting(),
        expect: () => <AdminSettingState>[
          GetSettingLoadingState(setting: tInitialSetting),
          GetSettingSuccessState(setting: tInitialSetting)
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
          GetSettingLoadingState(setting: tInitialSetting),
          GetSettingFailureState(setting: tInitialSetting, errorMessage: '')
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

      final tUpdatedSetting = SettingModel.fromUpdateSettingParams(tParams);

      test('should call repository.updateSetting() once.', () async {
        // Arrange
        when(mockRepository.updateSetting(any))
            .thenAnswer((_) async => tInitialSetting);

        // Act
        cubit.updateSetting(tParams);
        await untilCalled(mockRepository.updateSetting(any));

        // Assert
        verify(mockRepository.updateSetting(any)).called(1);
      });

      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [UpdateSettingLoadingState, UpdateSettingSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.updateSetting(any))
              .thenAnswer((_) async => tUpdatedSetting);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateSetting(tParams),
        expect: () => <AdminSettingState>[
          UpdateSettingLoadingState(setting: tInitialSetting),
          UpdateSettingSuccessState(setting: tUpdatedSetting)
        ],
      );

      blocTest<AdminSettingCubit, AdminSettingState>(
        'emits [UpdateSettingLoadingState, UpdateSettingFailureState] when repo is  failed.',
        setUp: () {
          when(mockRepository.updateSetting(any))
              .thenThrow(const UpdateSettingException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.updateSetting(tParams),
        expect: () => <AdminSettingState>[
          UpdateSettingLoadingState(setting: tInitialSetting),
          UpdateSettingFailureState(
            setting: tInitialSetting,
            errorMessage: '',
          )
        ],
      );
    });
  });
}
