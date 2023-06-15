import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/admin_note_form.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/domain/entities/payment.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_small_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/order_status_label.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class FoodOrderDialog extends StatefulWidget {
  final FoodOrder foodOrder;

  const FoodOrderDialog({super.key, required this.foodOrder});

  @override
  State<FoodOrderDialog> createState() => _FoodOrderDialogState();
}

class _FoodOrderDialogState extends State<FoodOrderDialog> {
  late FoodOrder _foodOrder;

  final nextStatus = ValueNotifier<OrderStatus?>(null);
  final cancelStatus = ValueNotifier<OrderStatus?>(null);

  @override
  void initState() {
    super.initState();
    _setFoodOrderAndActions(widget.foodOrder);
  }

  Future<void> _updateStatus(OrderStatus status) async {
    final params = UpdateFoodOrderStatusParams(
      id: _foodOrder.id,
      status: status,
    );

    context.read<AdminFoodOrderCubit>().updateFoodOrderStatus(params);
  }

  void _setFoodOrderAndActions(FoodOrder foodOrder) {
    _foodOrder = foodOrder;

    switch (_foodOrder.status) {
      case OrderStatus.paymentPending:
        nextStatus.value = OrderStatus.processing;
        cancelStatus.value = OrderStatus.cancelled;
      case OrderStatus.processing:
        nextStatus.value = OrderStatus.completed;
        cancelStatus.value = OrderStatus.cancelled;
      default:
        nextStatus.value = null;
        cancelStatus.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.r, 0, 20.r, 20.r),
          child: SafeArea(
            child: BlocConsumer<AdminFoodOrderCubit, AdminFoodOrderState>(
              listener: (context, state) {
                if (state is UpdateFoodOrderStatusFailureState) {
                  context.showErrorSnackBar(state.errorMessage!);
                }
              },
              builder: (context, state) {
                if (state is UpdateFoodOrderStatusSuccessState &&
                    _foodOrder.id == state.foodOrder.id) {
                  _setFoodOrderAndActions(state.foodOrder);
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OrderStatusLabel(foodOrder: _foodOrder),
                      ],
                    ),
                    20.h.height,
                    HeaderSection(foodOrder: _foodOrder),
                    const SectionDivider(),
                    DetailSection(foodOrder: _foodOrder),
                    10.h.height,
                    NoteSection(foodOrder: _foodOrder),
                    const SectionDivider(),
                    PaymentSection(payment: _foodOrder.payment),
                    10.h.height,
                    DeliverySection(foodOrder: _foodOrder),
                    const SectionDivider(),
                    AdminNoteForm(foodOrder: _foodOrder),
                    5.h.height,
                    if (_foodOrder.canUpdateStatus) ...[
                      20.h.height,
                      if (state is UpdateFoodOrderStatusLoadingState)
                        const LoadingIndicator()
                      else
                        Row(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: nextStatus,
                                builder: (context, value, child) {
                                  if (value != null) {
                                    return AppSmallElevatedButton(
                                      label: value == OrderStatus.completed
                                          ? 'Selesai'
                                          : 'Proses',
                                      onPressed: () => _updateStatus(value),
                                    );
                                  }

                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            10.w.width,
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: cancelStatus,
                                builder: (context, value, child) {
                                  if (value != null) {
                                    return AppSmallElevatedButton(
                                      label: 'Batal',
                                      isCancel: true,
                                      onPressed: () => _updateStatus(value),
                                    );
                                  }

                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ],
                );
              },
            ),
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
                  width: 30.r,
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
      ],
    );
  }
}
