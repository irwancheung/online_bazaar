import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_menu_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/item_card.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class MenuPageView extends StatefulWidget {
  final String name;
  final String pickupNote;
  final DateTime startAt;
  final DateTime endAt;

  const MenuPageView({
    super.key,
    required this.name,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 100.r,
                    child: Image.asset('assets/icons/app_logo.png'),
                  ),
                  20.h.height,
                  appText.xl(
                    widget.name,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  5.h.height,
                  appText.caption(
                    '${widget.startAt.dMMMy} - ${widget.endAt.subtract(const Duration(seconds: 1)).dMMMy}',
                  ),
                  10.h.height,
                  appText.label(
                    'Note:\n${widget.pickupNote}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
                    padding: const EdgeInsets.only(bottom: 50, left: 30),
                    scrollDirection: Axis.horizontal,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCard(key: UniqueKey(), item: _items[index]);
                    },
                  );
                }

                return Center(child: appText.body('Belum ada menu.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
