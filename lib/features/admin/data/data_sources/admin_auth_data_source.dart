import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_bazaar/core/exceptions/auth_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/data/models/admin_model.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';

class AdminAuthDataSource {
  final FirebaseAuth _auth;
  const AdminAuthDataSource({required FirebaseAuth auth}) : _auth = auth;

  Future<AdminModel> logIn(LoginParams params) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return AdminModel.fromFirebaseAuthUser(userCredential.user!);
    } catch (e, s) {
      logger.error(e, s);

      if (e is FirebaseAuthException) {
        late final String code;

        if (e.code == 'unknown') {
          final regExp = RegExp(r'\(auth\/(.*?)\)');
          final match = regExp.firstMatch(e.message!);

          code = match?.group(1) ?? '';
        } else {
          code = e.code;
        }

        throw LoginException.fromFirebaseCode(code);
      }

      throw const LoginException();
    }
  }

  bool isLoggedIn() {
    try {
      return _auth.currentUser != null;
    } catch (e, s) {
      logger.error(e, s);
      throw const LoginStatusCheckException();
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e, s) {
      logger.error(e, s);
      throw const LogoutException();
    }
  }
}
