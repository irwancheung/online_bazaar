import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/item_card.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/menu_item_dialog.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class MenuPageView extends StatefulWidget {
  const MenuPageView({super.key});

  @override
  State<MenuPageView> createState() => _MenuPageViewState();
}

class _MenuPageViewState extends State<MenuPageView>
    with AutomaticKeepAliveClientMixin {
  List<MenuItem> _items = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminMenuCubit>().getMenuItems();
      context.read<AdminSettingCubit>().getSetting();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        BackgroundContainer(
          child: BlocBuilder<AdminMenuCubit, AdminMenuState>(
            builder: (context, state) {
              if (state is GetMenuItemsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetMenuItemsFailureState) {
                return Center(child: appText.body(state.errorMessage!));
              }

              if (state is GetMenuItemsSuccessState) {
                _items = state.menuItems;
              }

              if (_items.isNotEmpty) {
                return ListView.builder(
                  itemCount: _items.length,
                  padding: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 70.r),
                  itemBuilder: (context, index) {
                    return ItemCard(item: _items[index]);
                  },
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/no_menu_item.png', height: 100.r),
                  10.h.height,
                  appText.body('Belum ada menu.', fontWeight: FontWeight.w600),
                ],
              );
            },
          ),
        ),
        Positioned(
          bottom: 20.r,
          right: 20.r,
          child: FloatingActionButton(
            onPressed: () {
              context.showContentDialog(
                const MenuItemDialog(type: MenuItemFormType.newItem),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
