import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/add_to_cart_dialog.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/circle_network_image.dart';

class ItemCard extends StatefulWidget {
  final MenuItem item;

  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _outOfStock = false;
  Color? _textColor;
  TextDecoration? _decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.item.remainingQuantity == 0) {
      _outOfStock = true;
      _textColor = theme.hintColor;
      _decoration = TextDecoration.lineThrough;
    }

    return InkWell(
      onTap: !_outOfStock
          ? () {
              context.showContentDialog(
                AddToCartDialog(item: widget.item),
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                const Spacer(),
                AppCard(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    width: 200.w,
                    height: 250.h,
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        const Spacer(),
                        if (_outOfStock)
                          Column(
                            children: [
                              appText.body(
                                'Habis',
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                              20.h.height,
                            ],
                          ),
                        SizedBox(
                          height: 100.h,
                          child: Column(
                            children: [
                              appText.body(
                                widget.item.name,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                color: _textColor,
                                decoration: _decoration,
                              ),
                              5.h.height,
                              appText.label(
                                widget.item.variants.join(', '),
                                color: theme.hintColor,
                                overflow: TextOverflow.ellipsis,
                                decoration: _decoration,
                              ),
                              const Spacer(),
                              appText.caption(
                                widget.item.sellingPrice.toCurrencyFormat(),
                                color: _textColor,
                                decoration: _decoration,
                              ),
                              20.h.height,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 30,
              child: CircleNetworkImage(
                url: widget.item.image,
                radius: 70.r,
                grayScale: _outOfStock,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
