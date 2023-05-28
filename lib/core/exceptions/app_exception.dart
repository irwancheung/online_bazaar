class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class SheetGeneratorException extends AppException {
  const SheetGeneratorException([
    super.message = 'Gagal membuat file sheet.',
  ]);
}
