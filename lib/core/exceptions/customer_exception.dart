import 'package:online_bazaar/core/exceptions/app_exception.dart';

class SetCustomerException extends AppException {
  const SetCustomerException([
    super.message = 'Gagal menyimpan data pelanggan.',
  ]);
}
