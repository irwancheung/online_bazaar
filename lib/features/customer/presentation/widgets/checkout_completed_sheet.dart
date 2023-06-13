import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class CheckoutCompletedSheet extends StatefulWidget {
  final FoodOrder foodOrder;

  const CheckoutCompletedSheet({super.key, required this.foodOrder});

  @override
  State<CheckoutCompletedSheet> createState() => _CheckoutCompletedSheetState();
}

class _CheckoutCompletedSheetState extends State<CheckoutCompletedSheet> {
  Future<void> _takeScreenshot() async {
    context.read<CustomerFoodOrderCubit>().downloadFoodOrderReceipt(
          DownloadFoodOrderReceiptParams(foodOrder: widget.foodOrder),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        title: 'Pesanan Berhasil!',
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.r, 0, 30.r, 30.r),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    HeaderSection(foodOrder: widget.foodOrder),
                    const SectionDivider(),
                    DetailSection(foodOrder: widget.foodOrder),
                    10.h.height,
                    NoteSection(foodOrder: widget.foodOrder),
                    const SectionDivider(),
                    DeliverySection(foodOrder: widget.foodOrder),
                    const SectionDivider(),
                    PaymentSection(payment: widget.foodOrder.payment),
                  ],
                ),
              ),
              20.h.height,
              BlocConsumer<CustomerFoodOrderCubit, CustomerFoodOrderState>(
                listener: (context, state) {
                  if (state is DownloadFoorOrderReceiptSuccessState) {
                    context.showSnackBar('Berhasil menyimpan resi.');
                    return;
                  }

                  if (state is DownloadFoorOrderReceiptFailureState) {
                    context.showErrorSnackBar('Gagal menyimpan resi.');
                    return;
                  }
                },
                builder: (context, state) {
                  if (state is DownloadFoorOrderReceiptLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return AppElevatedButton(
                    label: 'Simpan Resi',
                    onPressed: _takeScreenshot,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 30.h);
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
        appText.header(
          event.name,
          color: Colors.black,
          textAlign: TextAlign.center,
        ),
        5.h.height,
        appText.smLabel(
          '${event.startAt.dMMMy} - ${event.endAt.subtract(const Duration(days: 1)).dMMMy}',
          color: theme.hintColor,
          textAlign: TextAlign.center,
        ),
        20.h.height,
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
    final theme = Theme.of(context);

    return Column(
      children: [
        for (final item in foodOrder.items)
          Padding(
            padding: EdgeInsets.only(
              bottom: item != foodOrder.items.last ? 10.r : 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                  child: appText.caption('${item.quantity}x'),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText.caption(
                        item.name,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (item.variant.isNotEmpty)
                        appText.label(
                          item.variant,
                          color: theme.hintColor,
                        ),
                    ],
                  ),
                ),
                20.w.width,
                appText.label(item.price.toCurrencyFormat()),
              ],
            ),
          ),
        20.h.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appText.body('Total', fontWeight: FontWeight.w600),
            appText.body(foodOrder.totalPrice.toCurrencyFormat()),
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
        appText.caption('Catatan', fontWeight: FontWeight.w600),
        20.w.width,
        Expanded(
          child: appText.caption(
            foodOrder.note.isNotEmpty ? foodOrder.note : '-',
            textAlign: TextAlign.end,
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
    final deliveryAddress = foodOrder.deliveryAddress;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appText.caption(
              'Pengiriman',
              fontWeight: FontWeight.w600,
            ),
            appText.caption(
              foodOrder.type == OrderType.pickup
                  ? 'Ambil di tempat'
                  : 'Antar ke alamat',
            ),
          ],
        ),
        10.h.height,
        if (foodOrder.type == OrderType.pickup)
          appText.label(event.pickupNote)
        else
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                appText.label(
                  deliveryAddress!.name,
                  fontWeight: FontWeight.w600,
                ),
                appText.label(
                  deliveryAddress.phone,
                  fontWeight: FontWeight.w600,
                ),
                appText.label(
                  deliveryAddress.address,
                  fontWeight: FontWeight.w600,
                ),
                10.h.height,
                appText.label(
                  'Total pesanan belum termasuk biaya pengiriman.\nSilahkan hubungi admin untuk informasi lebih lanjut.',
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
            ),
            appText.caption(
              payment.type == PaymentType.bankTransfer
                  ? 'Bank Transfer'
                  : 'Tunai',
            ),
          ],
        ),
        if (payment.type == PaymentType.bankTransfer)
          Column(
            children: [
              10.h.height,
              appText.label(
                'Silahkan transfer ke rekening dibawah ini:',
                fontStyle: FontStyle.italic,
              ),
              5.h.height,
              appText.label(
                payment.transferTo,
                fontWeight: FontWeight.w600,
              ),
              10.h.height,
              appText.label(
                'Format berita transfer:',
                fontStyle: FontStyle.italic,
              ),
              5.h.height,
              appText.label(
                payment.transferNoteFormat,
                fontWeight: FontWeight.w600,
              ),
              10.h.height,
              appText.label(
                'Kirim bukti transfer ke:',
                fontStyle: FontStyle.italic,
              ),
              5.h.height,
              appText.label(
                payment.sendTransferProofTo,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
      ],
    );
  }
}
