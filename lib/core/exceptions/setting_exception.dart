import 'package:online_bazaar/core/exceptions/app_exception.dart';

class GetSettingException extends AppException {
  const GetSettingException([
    super.message = 'Gagal memuat pengaturan .',
  ]);
}

class UpdateSettingException extends AppException {
  const UpdateSettingException([
    super.message = 'Gagal memperbarui pengaturan.',
  ]);
}
