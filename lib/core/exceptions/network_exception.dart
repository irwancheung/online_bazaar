import 'package:online_bazaar/core/exceptions/app_exception.dart';

class NetworkException extends AppException {
  NetworkException([super.message = 'Terjadi kesalahan jaringan.']);
}
