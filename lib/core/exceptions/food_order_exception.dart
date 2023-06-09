import 'package:online_bazaar/core/exceptions/app_exception.dart';

class UpdateFoodOrderStatusException extends AppException {
  const UpdateFoodOrderStatusException([
    super.message = 'Gagal memperbarui status pesanan.',
  ]);
}

class UpdateAdminNoteException extends AppException {
  const UpdateAdminNoteException([
    super.message = 'Gagal memperbarui catatan admin.',
  ]);
}

class DownloadFoodOrderReceiptException extends AppException {
  const DownloadFoodOrderReceiptException([
    super.message = 'Gagal membuat struk pesanan.',
  ]);
}

class ExportFoodOrdersToSheetFileException extends AppException {
  const ExportFoodOrdersToSheetFileException([
    super.message = 'Gagal mengekspor pesanan ke file sheet.',
  ]);
}
