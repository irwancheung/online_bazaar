import 'package:online_bazaar/core/enums/cart_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/cart_item_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/rectangle_network_image.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class UpdateCartDialog extends StatelessWidget {
  final CartItem cartItem;

  const UpdateCartDialog({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: RectangleNetworkImage(
              url: cartItem.item.image,
              fit: BoxFit.cover,
              borderRadius: 10.r,
            ),
          ),
          Expanded(
            flex: 3,
            child: CartItemForm(
              cartItem: cartItem,
              action: CartAction.update,
            ),
          ),
        ],
      ),
    );
  }
}
