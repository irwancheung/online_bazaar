import 'package:online_bazaar/core/enums/food_order_enum.dart';

extension StringExtension on String {
  int toInteger() {
    return int.parse(replaceAll(RegExp('[^0-9]'), ''));
  }

  int toAscii() {
    return codeUnitAt(0);
  }

  OrderType toOrderTypeEnum() {
    return OrderType.values.firstWhere((e) => e.name == this);
  }

  PaymentType toPaymentTypeEnum() {
    return PaymentType.values.firstWhere((e) => e.name == this);
  }

  OrderStatus toOrderStatusEnum() {
    return OrderStatus.values.firstWhere((e) => e.name == this);
  }
}
