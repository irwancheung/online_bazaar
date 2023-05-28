import 'package:intl/intl.dart';

extension FormatExtension on int {
  String toCurrencyFormat() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format(this);
  }

  String toChar() {
    return String.fromCharCode(this);
  }
}
