import 'package:equatable/equatable.dart';

class FoodOrderConfig extends Equatable {
  final String orderNumberPrefix;

  const FoodOrderConfig({required this.orderNumberPrefix});

  @override
  List<Object?> get props => [orderNumberPrefix];
}
