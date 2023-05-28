import 'package:online_bazaar/core/exceptions/app_exception.dart';

class LoginException extends AppException {
  const LoginException([super.message = 'Gagal login.']);

  factory LoginException.fromFirebaseCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginException('Email tidak valid.');
      case 'user-disabled':
        return const LoginException('Pengguna dinonaktifkan.');
      case 'user-not-found':
        return const LoginException('Pengguna tidak ditemukan.');
      case 'wrong-password':
        return const LoginException('Password salah.');
      case 'operation-not-allowed':
        return const LoginException('Operasi tidak diizinkan.');
      default:
        return const LoginException();
    }
  }
}

class LoginStatusCheckException extends AppException {
  const LoginStatusCheckException([
    super.message = 'Gagal memeriksa status login.',
  ]);
}

class LogoutException extends AppException {
  const LogoutException([super.message = 'Gagal logout.']);
}
