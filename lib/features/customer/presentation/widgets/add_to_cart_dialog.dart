import 'package:online_bazaar/core/enums/cart_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/cart_item_form.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/rectangle_network_image.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

class AddToCartDialog extends StatelessWidget {
  final MenuItem item;

  const AddToCartDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: ListView(
        children: [
          RectangleNetworkImage(
            url: item.image,
            fit: BoxFit.cover,
          ),
          CartItemForm(item: item, action: CartAction.add),
        ],
      ),
    );
  }
}
