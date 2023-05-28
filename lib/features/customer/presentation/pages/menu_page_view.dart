import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_menu_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/item_card.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class MenuPageView extends StatefulWidget {
  final String title;
  final String pickupNote;
  final DateTime startAt;
  final DateTime endAt;

  const MenuPageView({
    super.key,
    required this.title,
    required this.pickupNote,
    required this.startAt,
    required this.endAt,
  });

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
      context.read<CustomerMenuCubit>().getMenuItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BackgroundContainer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 100.r,
                  child: Image.asset('assets/icons/app_logo.png'),
                ),
                20.h.height,
                appText.xl(widget.title, fontWeight: FontWeight.w600),
                5.h.height,
                appText.caption(
                  'Periode ${widget.startAt.dMMMy} - ${widget.endAt.dMMMy}',
                ),
                5.h.height,
                appText.label(
                  widget.pickupNote,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: BlocBuilder<CustomerMenuCubit, CustomerMenuState>(
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
                    padding: EdgeInsets.only(bottom: 30.h),
                    scrollDirection: Axis.horizontal,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCard(key: UniqueKey(), item: _items[index]);
                    },
                  );
                }

                return appText.body('Belum ada menu.');
              },
            ),
          ),
        ],
      ),
    );
  }
}
