import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final value = newValue.text.replaceAll('.', '');
    final n = int.tryParse(value);
    if (n == null) {
      return oldValue;
    }

    final newString = NumberFormat('#,###', 'id_ID').format(n);
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
