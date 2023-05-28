import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/cart_item_row.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/checkout_bottom_sheet.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({super.key});

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<CustomerCartCubit>().state.cart.items.isNotEmpty) {
        context.read<CustomerCartCubit>().validateCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      padding: EdgeInsets.all(20.r),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: BlocConsumer<CustomerCartCubit, CustomerCartState>(
            listener: (context, state) {
              if (state is ValidateCartLoadingState) {
                context.showProgressIndicatorDialog();
              }

              if (state is ValidateCartSuccessState) {
                context.pop();
              }
            },
            builder: (context, state) {
              final cart = state.cart;

              if (cart.items.isEmpty) {
                return Center(
                  child: appText.body(
                    'Belum ada barang di keranjang.',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart.items[index];

                        return Column(
                          children: [
                            CartItemRow(key: UniqueKey(), cartItem: cartItem),
                            if (cartItem != cart.items.last)
                              Divider(height: 40.h),
                          ],
                        );
                      },
                    ),
                  ),
                  20.h.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appText.body('Total', fontWeight: FontWeight.w600),
                      appText.body(cart.totalPrice.toCurrencyFormat()),
                    ],
                  ),
                  20.h.height,
                  if (cart.customer == null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: appText.caption(
                        'Data Profil masih kosong.\nSilahkan diisi terlebih dahulu.',
                        color: Theme.of(context).colorScheme.error,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  AppElevatedButton(
                    label: 'Checkout',
                    onPressed: cart.canCheckout
                        ? () => context.showBottomSheet(
                              SafeArea(child: CheckoutBottomSheet(cart: cart)),
                            )
                        : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
