import 'package:online_bazaar/core/enums/cart_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/cart_item_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class UpdateCartDialog extends StatelessWidget {
  final CartItem cartItem;

  const UpdateCartDialog({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: CartItemForm(cartItem: cartItem, action: CartAction.update),
    );
  }
}
