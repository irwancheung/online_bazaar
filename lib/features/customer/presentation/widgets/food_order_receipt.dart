import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';

class FoodOrderReceipt extends StatelessWidget {
  final FoodOrder foodOrder;

  const FoodOrderReceipt({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderSection(foodOrder: foodOrder),
          const SectionDivider(),
          DetailSection(foodOrder: foodOrder),
          10.height,
          NoteSection(foodOrder: foodOrder),
          const SectionDivider(),
          DeliverySection(foodOrder: foodOrder),
          const SectionDivider(),
          PaymentSection(payment: foodOrder.payment),
        ],
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 20);
  }
}

class HeaderSection extends StatelessWidget {
  final FoodOrder foodOrder;
  const HeaderSection({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = foodOrder.event;
    return Column(
      children: [
        Image.asset(
          'assets/icons/app_logo.png',
          height: 50,
          width: 50,
        ),
        5.height,
        appText.header(event.name, color: Colors.black),
        5.height,
        appText.smLabel(
          '${event.startAt.dMMMy} - ${event.endAt.subtract(const Duration(days: 1)).dMMMy}',
          color: theme.hintColor,
        ),
        20.height,
        Row(
          children: [
            appText.caption(
              'ID: ${foodOrder.id}',
              color: theme.hintColor,
            ),
            const Spacer(),
            appText.caption(
              foodOrder.createdAt!.dMMMy,
              color: theme.hintColor,
            ),
          ],
        ),
      ],
    );
  }
}

class DetailSection extends StatelessWidget {
  final FoodOrder foodOrder;
  const DetailSection({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  child: appText.label(
                    '${item.quantity}x',
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText.label(
                        item.name,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (item.variant.isNotEmpty)
                        appText.smLabel(
                          item.variant,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                ),
                20.width,
                appText.label(
                  item.price.toCurrencyFormat(),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        20.height,
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
      ],
    );
  }
}

class NoteSection extends StatelessWidget {
  final FoodOrder foodOrder;
  const NoteSection({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: appText.caption(
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
    );
  }
}

class DeliverySection extends StatelessWidget {
  final FoodOrder foodOrder;
  const DeliverySection({super.key, required this.foodOrder});

  @override
  Widget build(BuildContext context) {
    final event = foodOrder.event;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appText.caption(
              'Pengiriman',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            appText.caption(
              foodOrder.type == OrderType.pickup
                  ? 'Ambil di tempat'
                  : 'Antar ke alamat',
              color: Colors.black,
            ),
          ],
        ),
        10.height,
        if (foodOrder.type == OrderType.pickup)
          appText.label(event.pickupNote, color: Colors.black)
        else
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                appText.label(
                  foodOrder.deliveryAddress!.name,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                appText.label(
                  foodOrder.deliveryAddress!.phone,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                appText.label(
                  foodOrder.deliveryAddress!.address,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                10.h.height,
                appText.label(
                  'Total pesanan belum termasuk biaya pengiriman.\nSilahkan hubungi admin untuk informasi lebih lanjut.',
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  fontStyle: FontStyle.italic,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class PaymentSection extends StatelessWidget {
  final Payment payment;
  const PaymentSection({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appText.caption(
              'Pembayaran',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            appText.caption(
              payment.type == PaymentType.bankTransfer
                  ? 'Bank Transfer'
                  : 'Tunai',
              color: Colors.black,
            ),
          ],
        ),
        if (payment.type == PaymentType.bankTransfer)
          Column(
            children: [
              10.height,
              appText.label(
                'Silahkan transfer ke rekening dibawah ini:',
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              5.height,
              appText.label(
                payment.transferTo,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              10.height,
              appText.label(
                'Format berita transfer:',
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              5.height,
              appText.label(
                payment.transferNoteFormat,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              10.height,
              appText.label(
                'Kirim bukti transfer ke:',
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              5.height,
              appText.label(
                payment.sendTransferProofTo,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
      ],
    );
  }
}
