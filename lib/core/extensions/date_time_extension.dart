import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dMMMy => DateFormat('d MMM y', 'id_ID').format(this);
}
