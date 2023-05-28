import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_auth_cubit.dart';

import '../../../../helpers.dart';
import 'admin_auth_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdminAuthRepository>()])
void main() {
  initHelpersTest();

  late MockAdminAuthRepository mockRepository;
  late AdminAuthCubit cubit;

  setUp(() {
    mockRepository = MockAdminAuthRepository();
    cubit = AdminAuthCubit(repository: mockRepository);
  });

  group('AdminAuthCubit', () {
    group('login()', () {
      const tEmail = 'email';
      const tPassword = 'password';
      const tLoginParams = LoginParams(email: tEmail, password: tPassword);

      const tAdmin = Admin(
        id: 'id',
        email: 'email',
        name: 'name',
      );

      test('should call repository.login() once.', () async {
        // Arrange
        when(
          mockRepository.logIn(any),
        ).thenAnswer((_) async => tAdmin);

        // Act
        await cubit.logIn(tLoginParams);

        // Assert
        verify(mockRepository.logIn(any)).called(1);
      });

      blocTest<AdminAuthCubit, AdminAuthState>(
        'should emit [LogInLoadingState, LogInSuccessState] when usecase is successful.',
        setUp: () {
          when(
            mockRepository.logIn(any),
          ).thenAnswer((_) async => tAdmin);
        },
        build: () => cubit,
        act: (cubit) => cubit.logIn(tLoginParams),
        expect: () => <AdminAuthState>[
          const LoginLoadingState(),
          const LoginSuccessState(admin: tAdmin),
        ],
      );
    });
  });
}
