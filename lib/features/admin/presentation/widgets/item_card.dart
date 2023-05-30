import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/menu_item_dialog.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/rectangle_network_image.dart';

class ItemCard extends StatefulWidget {
  final MenuItem item;
  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => context.showContentDialog(
        MenuItemDialog(
          type: MenuItemFormType.editItem,
          item: widget.item,
        ),
      ),
      child: AppCard(
        borderRadius: 10.r,
        margin: EdgeInsets.only(bottom: 10.h),
        child: Container(
          margin: EdgeInsets.fromLTRB(10.r, 10.r, 10.r, 0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox.square(
                    dimension: 100.r,
                    child: RectangleNetworkImage(
                      url: widget.item.image,
                      borderRadius: 10.r,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText.caption(
                          widget.item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        appText.label(
                          widget.item.variants.join(', '),
                          color: theme.hintColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                        10.h.height,
                        appText.caption(
                          widget.item.sellingPrice.toCurrencyFormat(),
                        ),
                        5.h.height,
                        appText
                            .caption('Stok: ${widget.item.remainingQuantity}'),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appText.label(widget.item.isVisible ? 'Aktif' : 'Nonaktif'),
                  BlocBuilder<AdminMenuCubit, AdminMenuState>(
                    builder: (context, state) {
                      if (state is SetMenuItemVisibilitySuccessState) {}

                      return Switch(
                        value: widget.item.isVisible,
                        onChanged: (value) => context
                            .read<AdminMenuCubit>()
                            .setMenuItemVisibility(
                              SetMenuItemVisibilityParams(
                                id: widget.item.id,
                                isVisible: value,
                              ),
                            ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
