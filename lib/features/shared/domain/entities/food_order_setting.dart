import 'package:equatable/equatable.dart';

class FoodOrderSetting extends Equatable {
  final String orderNumberPrefix;

  const FoodOrderSetting({required this.orderNumberPrefix});

  @override
  List<Object?> get props => [orderNumberPrefix];
}
