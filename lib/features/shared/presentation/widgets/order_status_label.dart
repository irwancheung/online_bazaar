import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

class OrderStatusLabel extends StatelessWidget {
  final FoodOrder foodOrder;

  const OrderStatusLabel({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    late final Color labelColor;

    switch (foodOrder.status) {
      case OrderStatus.paymentPending:
        labelColor = Colors.orange;
      case OrderStatus.processing:
        labelColor = Colors.blue;
      case OrderStatus.completed:
        labelColor = Colors.green;
      case OrderStatus.cancelled:
        labelColor = Colors.red;
      default:
        labelColor = Colors.black;
    }

    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: labelColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: appText.label(foodOrder.statusText, color: Colors.white),
    );
  }
}
