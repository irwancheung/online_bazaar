import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/checkout_completed_sheet.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/checkout_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final Cart cart;

  const CheckoutBottomSheet({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.9.sh,
      child: Scaffold(
        body: BlocConsumer<CustomerCartCubit, CustomerCartState>(
          listener: (context, state) {
            if (state is CompleteCheckoutLoadingState) {
              context.showProgressIndicatorDialog();
            }

            if (state is CompleteCheckoutSuccessState) {
              context.pop();
            }

            if (state is CompleteCheckoutFailureState) {
              context.showErrorSnackBar(state.errorMessage!);
              context.read<CustomerCartCubit>().validateCart();
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is CompleteCheckoutSuccessState) {
              return CheckoutCompletedSheet(foodOrder: state.foodOrder);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TopBar(title: 'Checkout'),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: CheckoutForm(cart: state.cart),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
