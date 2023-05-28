import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/auth_exception.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_auth_data_source.dart';
import 'package:online_bazaar/features/admin/data/models/admin_model.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_auth_repository_impl.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';

import '../../../../helpers.dart';
import 'admin_auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NetworkInfo>()])
@GenerateNiceMocks([MockSpec<AdminAuthDataSource>()])
void main() {
  initHelpersTest();

  late MockNetworkInfo mockNetworkInfo;
  late MockAdminAuthDataSource mockDataSource;
  late AdminAuthRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockAdminAuthDataSource();
    repository = AdminAuthRepositoryImpl(
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
        'should check if is connected to internet and throw NetworkException when there is no internet connection.',
        () async {
      // Arrange
      setInternetDisconnected();

      // Assert
      expect(method, throwsA(isA<NetworkException>()));
    });
  }

  group('AdminAuthRepositoryImpl', () {
    group('logIn()', () {
      const tEmail = 'email';
      const tPassword = 'password';
      const tLoginParams = LoginParams(email: tEmail, password: tPassword);

      runInternetDisconnectedTests(() => repository.logIn(tLoginParams));

      test('should return User when datasource.logIn() is successful.',
          () async {
        // Arrange
        setInternetConnected();

        when(
          mockDataSource.logIn(any),
        ).thenAnswer(
          (_) async => const AdminModel(
            id: 'id',
            email: 'email',
            name: 'name',
          ),
        );

        // Act
        final result = await repository.logIn(tLoginParams);

        // Assert
        verify(mockDataSource.logIn(any)).called(1);
        expect(result, isA<Admin>());
      });

      test('should throw LoginException when dataSource.logIn() is failed.',
          () async {
        // Arrange
        setInternetConnected();

        when(
          mockDataSource.logIn(any),
        ).thenThrow(const LoginException());

        // Act
        final call = repository.logIn;

        // Assert
        expect(call(tLoginParams), throwsA(isA<LoginException>()));
      });
    });

    group('isLoggedIn()', () {
      runInternetDisconnectedTests(() => repository.isLoggedIn());

      test('should return bool value from datasource.isLoggedIn().', () async {
        // Arrange
        const isLoggedIn = true;

        setInternetConnected();
        when(mockDataSource.isLoggedIn()).thenReturn(isLoggedIn);

        // Act
        final result = await repository.isLoggedIn();

        // Assert
        verify(mockDataSource.isLoggedIn()).called(1);
        expect(result, isLoggedIn);
      });
    });

    group('logOut()', () {
      runInternetDisconnectedTests(() => repository.logOut());

      test('verify dataSource.logOut() was called once.', () async {
        // Arrange
        setInternetConnected();
        when(mockDataSource.logOut()).thenAnswer((_) async {});

        // Act
        await repository.logOut();

        // Assert
        verify(mockDataSource.logOut()).called(1);
      });
    });
  });
}
