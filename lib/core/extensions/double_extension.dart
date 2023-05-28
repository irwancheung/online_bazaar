import 'package:flutter/widgets.dart';

extension WidgetExtension on double {
  SizedBox get width => SizedBox(width: this);
  SizedBox get height => SizedBox(height: this);
}
