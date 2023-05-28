import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/update_cart_dialog.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class CartItemRow extends StatefulWidget {
  final CartItem cartItem;

  const CartItemRow({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartItemRow> createState() => _CartItemRowState();
}

class _CartItemRowState extends State<CartItemRow> {
  late final MenuItem _item;

  bool _outOfStock = false;
  Color? _textColor;
  TextDecoration? _decoration;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _item = widget.cartItem.item;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CustomerCartCubit>();

    if (_item.remainingQuantity < widget.cartItem.quantity) {
      _textColor = theme.colorScheme.error;
      _errorText =
          'Menu tidak cukup. Hanya tersisa ${_item.remainingQuantity}.';
    }

    if (_item.remainingQuantity == 0) {
      _outOfStock = true;
      _textColor = theme.hintColor;
      _decoration = TextDecoration.lineThrough;
      _errorText = 'Menu habis.';
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50.w,
                child: appText.label(
                  '${widget.cartItem.quantity}x',
                  color: _textColor,
                  decoration: _decoration,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText.label(
                      widget.cartItem.item.name,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      color: _textColor,
                      decoration: _decoration,
                      maxLines: 2,
                    ),
                    if (widget.cartItem.variant.isNotEmpty)
                      appText.label(
                        widget.cartItem.variant,
                        color: theme.hintColor,
                      ),
                  ],
                ),
              ),
              20.w.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  appText.label(
                    widget.cartItem.item.sellingPrice.toCurrencyFormat(),
                    color: _textColor,
                    decoration: _decoration,
                  ),
                  10.h.height,
                  Row(
                    children: [
                      if (!_outOfStock)
                        InkWell(
                          child: FaIcon(
                            FontAwesomeIcons.solidPenToSquare,
                            color: theme.hintColor,
                            size: 15.r,
                          ),
                          onTap: () => context.showContentDialog(
                            UpdateCartDialog(cartItem: widget.cartItem),
                          ),
                        ),
                      20.w.width,
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.solidTrashCan,
                          color: theme.hintColor,
                          size: 15.r,
                        ),
                        onTap: () => cubit.removeCartItem(
                          RemoveCartItemParams(
                            cart: cubit.state.cart,
                            cartItemId: widget.cartItem.id,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (_errorText != null)
            appText.label(_errorText!, color: theme.colorScheme.error),
        ],
      ),
    );
  }
}
