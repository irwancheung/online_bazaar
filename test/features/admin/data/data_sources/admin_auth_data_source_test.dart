import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:online_bazaar/core/exceptions/auth_exception.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_auth_data_source.dart';
import 'package:online_bazaar/features/admin/data/models/admin_model.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';

import '../../../../helpers.dart';

void main() {
  initHelpersTest();

  late MockFirebaseAuth mockFirebaseAuth;
  late AdminAuthDataSource dataSource;

  const tEmail = 'email';
  const tPassword = 'password';
  const tLoginParams = LoginParams(email: tEmail, password: tPassword);

  group('AdminAuthDataSource', () {
    group('logIn()', () {
      test('should return AdminModel.', () async {
        // Arrange
        mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser(email: tEmail));
        dataSource = AdminAuthDataSource(auth: mockFirebaseAuth);

        // Act
        final result = await dataSource.logIn(tLoginParams);

        // Assert
        expect(result, isA<AdminModel>());
        expect(result.email, tEmail);
      });

      test('should throw LoginException when any errors occured.', () async {
        // Arrange
        mockFirebaseAuth = MockFirebaseAuth();
        dataSource = AdminAuthDataSource(auth: mockFirebaseAuth);

        whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
            .on(mockFirebaseAuth)
            .thenThrow(FirebaseAuthException(code: 'code'));

        // Act
        final call = dataSource.logIn;

        // Assert
        expect(call(tLoginParams), throwsA(isA<LoginException>()));
      });
    });

    group('isLoggedIn()', () {
      test('should return true when firebaseAuth.currentUser is not null.',
          () async {
        // Arrange
        mockFirebaseAuth = MockFirebaseAuth(
          signedIn: true,
          mockUser: MockUser(email: tEmail),
        );
        dataSource = AdminAuthDataSource(auth: mockFirebaseAuth);

        // Act
        final result = dataSource.isLoggedIn();

        // Assert
        expect(result, true);
      });

      test('should return false when firebaseAuth.currentUser is null.',
          () async {
        // Arrange
        mockFirebaseAuth = MockFirebaseAuth();
        dataSource = AdminAuthDataSource(auth: mockFirebaseAuth);

        // Act
        final result = dataSource.isLoggedIn();

        // Assert
        expect(result, false);
      });
    });
  });
}
