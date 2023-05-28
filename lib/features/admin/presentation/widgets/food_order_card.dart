import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/food_order_dialog.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/order_status_label.dart';

class FoodOrderCard extends StatelessWidget {
  final FoodOrder foodOrder;

  const FoodOrderCard({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final itemNames = foodOrder.items.map((e) {
      final quantity = e.quantity;
      final name = e.name;
      final variant = e.variant.isNotEmpty ? ' (${e.variant})' : '';

      return '${quantity}x $name$variant';
    }).join(', ');

    return InkWell(
      onTap: () => context.showContentDialog(
        FoodOrderDialog(foodOrder: foodOrder),
      ),
      child: AppCard(
        borderRadius: 10.r,
        margin: EdgeInsets.only(bottom: 10.h),
        child: Container(
          margin: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  appText.label(
                    foodOrder.orderNumber,
                    color: theme.hintColor,
                  ),
                  const Spacer(),
                  appText.label(
                    foodOrder.createdAt!.dMMMy,
                    color: theme.hintColor,
                  ),
                ],
              ),
              10.h.height,
              Row(
                children: [
                  appText.caption(
                    foodOrder.customer.name,
                  ),
                  const Spacer(),
                  appText.caption(
                    foodOrder.customer.chaitya,
                  ),
                ],
              ),
              Divider(height: 20.h),
              Row(
                children: [
                  appText.label('${foodOrder.totalQuantity} item'),
                  const Spacer(),
                  appText.label('Total Pesanan: '),
                  appText.label(
                    foodOrder.totalPrice.toCurrencyFormat(),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              10.h.height,
              appText.label(itemNames, color: theme.hintColor),
              Divider(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrderStatusLabel(foodOrder: foodOrder),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
