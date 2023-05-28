import 'package:online_bazaar/core/exceptions/app_exception.dart';

class GetMenuItemsByCartItemIdsException extends AppException {
  const GetMenuItemsByCartItemIdsException([
    super.message = 'Gagal mendapatkan menu berdasarkan id item keranjang.',
  ]);
}

class SetCartCustomerException extends AppException {
  const SetCartCustomerException([
    super.message = 'Gagal mengatur data pelanggan.',
  ]);
}

class AddCartItemException extends AppException {
  const AddCartItemException([
    super.message = 'Gagal menambahkan item keranjang.',
  ]);
}

class UpdateCartItemException extends AppException {
  const UpdateCartItemException([
    super.message = 'Gagal memperbarui item keranjang.',
  ]);
}

class RemoveCartItemException extends AppException {
  const RemoveCartItemException([
    super.message = 'Gagal menghapus item keranjang.',
  ]);
}

class ValidateCartException extends AppException {
  const ValidateCartException([super.message = 'Gagal memvalidasi keranjang.']);
}

class ConvertCartToFoodOrderException extends AppException {
  const ConvertCartToFoodOrderException([
    super.message = 'Gagal mengubah keranjang menjadi pesanan.',
  ]);
}

class CompleteCheckoutException extends AppException {
  const CompleteCheckoutException([
    super.message = 'Gagal menyelesaikan checkout.',
  ]);
}
