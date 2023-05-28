import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/presentation/cubit/config_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class CheckoutCompletedSheet extends StatefulWidget {
  final FoodOrder foodOrder;

  const CheckoutCompletedSheet({super.key, required this.foodOrder});

  @override
  State<CheckoutCompletedSheet> createState() => _CheckoutCompletedSheetState();
}

class _CheckoutCompletedSheetState extends State<CheckoutCompletedSheet> {
  late ConfigState _config;

  @override
  void initState() {
    super.initState();
    _config = context.read<ConfigCubit>().state;
  }

  Future<void> _takeScreenshot() async {
    context.read<CustomerFoodOrderCubit>().downloadFoodOrderReceipt(
          DownloadFoodOrderReceiptParams(foodOrder: widget.foodOrder),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = _config.event;

    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 30.r),
        child: SafeArea(
          child: Column(
            children: [
              appText.header('Pesanan Berhasil!'),
              Divider(height: 40.h, color: theme.hintColor),
              for (final item in widget.foodOrder.items)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: item != widget.foodOrder.items.last ? 10.r : 0,
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
              30.h.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText.body('Total', fontWeight: FontWeight.w600),
                  appText.body(widget.foodOrder.totalPrice.toCurrencyFormat()),
                ],
              ),
              Divider(height: 40.h, color: theme.hintColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText.caption('Pembayaran', fontWeight: FontWeight.w600),
                  appText.caption(
                    widget.foodOrder.paymentType == PaymentType.bankTransfer
                        ? 'Bank Transfer'
                        : 'Tunai',
                  ),
                ],
              ),
              10.h.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText.caption('Pengiriman', fontWeight: FontWeight.w600),
                  appText.caption(
                    widget.foodOrder.type == OrderType.delivery
                        ? 'Antar ke alamat'
                        : 'Ambil di tempat',
                  ),
                ],
              ),
              10.h.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText.caption(
                    'Catatan',
                    fontWeight: FontWeight.w600,
                  ),
                  20.w.width,
                  Expanded(
                    child: appText.caption(
                      widget.foodOrder.note.isNotEmpty
                          ? widget.foodOrder.note
                          : '-',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Divider(height: 40.h, color: theme.hintColor),
              if (widget.foodOrder.type == OrderType.pickup)
                appText.caption(event.pickupNote)
              else
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      appText.caption(
                        'Alamat Pengiriman',
                        fontWeight: FontWeight.w600,
                      ),
                      10.h.height,
                      appText.caption(widget.foodOrder.deliveryAddress!.name),
                      appText.caption(widget.foodOrder.deliveryAddress!.phone),
                      appText
                          .caption(widget.foodOrder.deliveryAddress!.address),
                    ],
                  ),
                ),
              const Spacer(),
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
