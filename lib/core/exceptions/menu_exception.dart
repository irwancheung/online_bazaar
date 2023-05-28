import 'package:online_bazaar/core/exceptions/app_exception.dart';

class AddMenuItemException extends AppException {
  const AddMenuItemException([super.message = 'Gagal menambahkan menu.']);
}

class UpdateMenuItemException extends AppException {
  const UpdateMenuItemException([super.message = 'Gagal memperbarui menu.']);
}

class SetMenuItemVisibilityException extends AppException {
  const SetMenuItemVisibilityException([
    super.message = 'Gagal mengatur visibilitas menu.',
  ]);
}

class UploadMenuItemImageException extends AppException {
  const UploadMenuItemImageException([
    super.message = 'Gagal mengunggah gambar menu.',
  ]);
}
