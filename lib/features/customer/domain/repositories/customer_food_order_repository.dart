import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

abstract class CustomerFoodOrderRepository {
  Future<void> downloadFoodOrderReceipt(DownloadFoodOrderReceiptParams params);
}

class DownloadFoodOrderReceiptParams extends Equatable {
  final FoodOrder foodOrder;

  const DownloadFoodOrderReceiptParams({
    required this.foodOrder,
  });

  @override
  List<Object?> get props => [foodOrder];
}
