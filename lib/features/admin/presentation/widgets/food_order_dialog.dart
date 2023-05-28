import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
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
    final theme = Theme.of(context);
    final event = widget.foodOrder.event;

    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
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
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OrderStatusLabel(foodOrder: _foodOrder),
                          ],
                        ),
                        20.h.height,
                        Column(
                          children: [
                            appText.header(event.title, color: Colors.black),
                            appText.smLabel(
                              '${event.startAt.dMMMy} - ${event.endAt.dMMMy}',
                              color: theme.hintColor,
                            ),
                          ],
                        ),
                        15.h.height,
                        Row(
                          children: [
                            appText.caption(
                              _foodOrder.orderNumber,
                              color: theme.hintColor,
                            ),
                            const Spacer(),
                            appText.caption(
                              _foodOrder.createdAt!.dMMMy,
                              color: theme.hintColor,
                            ),
                          ],
                        ),
                        10.h.height,
                        Row(
                          children: [
                            appText.body(
                              _foodOrder.customer.name,
                            ),
                            const Spacer(),
                            appText.body(
                              _foodOrder.customer.chaitya,
                            ),
                          ],
                        ),
                        Divider(height: 30.h, color: theme.hintColor),
                        for (final item in _foodOrder.items)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: item != _foodOrder.items.last ? 10.r : 0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            appText.body(
                              _foodOrder.totalPrice.toCurrencyFormat(),
                            ),
                          ],
                        ),
                        Divider(height: 30.h, color: theme.hintColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText.caption(
                              'Pembayaran',
                              fontWeight: FontWeight.w600,
                            ),
                            appText.caption(
                              _foodOrder.paymentType == PaymentType.bankTransfer
                                  ? 'Bank Transfer'
                                  : 'Tunai',
                            ),
                          ],
                        ),
                        10.h.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText.caption(
                              'Pengiriman',
                              fontWeight: FontWeight.w600,
                            ),
                            appText.caption(
                              _foodOrder.type == OrderType.delivery
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
                                _foodOrder.note.isNotEmpty
                                    ? _foodOrder.note
                                    : '-',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 30.h, color: theme.hintColor),
                        if (_foodOrder.type == OrderType.delivery)
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
                                appText.caption(
                                  _foodOrder.deliveryAddress!.name,
                                ),
                                appText.caption(
                                  _foodOrder.deliveryAddress!.phone,
                                ),
                                appText.caption(
                                  _foodOrder.deliveryAddress!.address,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
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
    );
  }
}
