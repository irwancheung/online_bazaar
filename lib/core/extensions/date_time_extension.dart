import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dMMMy => DateFormat('d MMM y', 'id_ID').format(this);
  String get dMMMyHHmm =>
      DateFormat('d MMM y, HH:mm WIB', 'id_ID').format(this);
}
