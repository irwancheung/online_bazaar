import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

class FoodOrderReceipt extends StatelessWidget {
  final FoodOrder foodOrder;

  const FoodOrderReceipt({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = foodOrder.event;

    return Container(
      width: 400,
      constraints: const BoxConstraints(minHeight: 400),
      color: Colors.white,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/app_logo.png',
            height: 50,
            width: 50,
          ),
          appText.header(event.title, color: Colors.black),
          appText.smLabel(
            '${event.startAt.dMMMy} - ${event.endAt.dMMMy}',
            color: theme.hintColor,
          ),
          15.h.height,
          Row(
            children: [
              appText.caption(
                foodOrder.orderNumber,
                color: theme.hintColor,
              ),
              const Spacer(),
              appText.caption(
                foodOrder.createdAt!.dMMMy,
                color: theme.hintColor,
              ),
            ],
          ),
          const Divider(height: 20),
          for (final item in foodOrder.items)
            Padding(
              padding: EdgeInsets.only(
                bottom: item != foodOrder.items.last ? 10 : 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    child: appText.caption(
                      '${item.quantity}x',
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText.caption(
                          item.name,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        if (item.variant.isNotEmpty)
                          appText.label(
                            item.variant,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  ),
                  20.0.width,
                  appText.label(
                    item.price.toCurrencyFormat(),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          30.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText.body(
                'Total',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              appText.body(
                foodOrder.totalPrice.toCurrencyFormat(),
                color: Colors.black,
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: appText.label(
                  'Pemesan',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: appText.label(
                  foodOrder.customer.name,
                  textAlign: TextAlign.end,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText.label(
                'Pembayaran',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              appText.label(
                foodOrder.paymentType == PaymentType.bankTransfer
                    ? 'Bank Transfer'
                    : 'Tunai',
                color: Colors.black,
              ),
            ],
          ),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText.label(
                'Pengiriman',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              appText.label(
                foodOrder.type == OrderType.delivery
                    ? 'Antar ke alamat'
                    : 'Ambil di tempat',
                color: Colors.black,
              ),
            ],
          ),
          10.0.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120,
                child: appText.label(
                  'Catatan',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: appText.label(
                  foodOrder.note.isNotEmpty ? foodOrder.note : '-',
                  textAlign: TextAlign.end,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          if (foodOrder.type == OrderType.pickup)
            appText.label(event.pickupNote, color: Colors.black)
          else
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  appText.label(
                    'Alamat Pengiriman',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  10.h.height,
                  appText.label(
                    foodOrder.deliveryAddress!.name,
                    color: Colors.black,
                  ),
                  appText.label(
                    foodOrder.deliveryAddress!.phone,
                    color: Colors.black,
                  ),
                  appText.label(
                    foodOrder.deliveryAddress!.address,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
