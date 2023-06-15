import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_setting_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/pages/cart_page_view.dart';
import 'package:online_bazaar/features/customer/presentation/pages/customer_profile_page_view.dart';
import 'package:online_bazaar/features/customer/presentation/pages/future_event_page.dart';
import 'package:online_bazaar/features/customer/presentation/pages/menu_page_view.dart';
import 'package:online_bazaar/features/customer/presentation/pages/no_event_page.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _activeIndex = ValueNotifier<int>(0);
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<CustomerSettingCubit>().getSetting();
  }

  void _changePage(int index) {
    _activeIndex.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CustomerSettingCubit, CustomerSettingState>(
      builder: (context, state) {
        final setting = state.setting;

        if (setting == null) {
          return const AppScaffold(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final event = state.setting!.event;
        final now = DateTime.now();

        if ((event.startAt == null && event.endAt == null) ||
            now.isAfter(event.endAt!)) {
          return const NoEventPage();
        }

        if (event.startAt!.isAfter(now)) {
          return FutureEventPage(event: event);
        }

        final canOrder =
            now.isAfter(event.startAt!) && now.isBefore(event.endAt!);

        return AppScaffold(
          bottomNavigationBar: canOrder
              ? ValueListenableBuilder(
                  valueListenable: _activeIndex,
                  builder: (context, index, child) {
                    return BottomNavigationBar(
                      showSelectedLabels: true,
                      currentIndex: _activeIndex.value,
                      onTap: _changePage,
                      items: [
                        const BottomNavigationBarItem(
                          icon: FaIcon(FontAwesomeIcons.bowlFood),
                          label: 'Menu',
                        ),
                        BottomNavigationBarItem(
                          icon:
                              BlocBuilder<CustomerCartCubit, CustomerCartState>(
                            builder: (context, state) {
                              if (state.cart.totalQuantity > 0) {
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.cartShopping,
                                    ),
                                    Positioned(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 4.r,
                                            backgroundColor:
                                                theme.colorScheme.background,
                                          ),
                                          CircleAvatar(
                                            radius: 3.r,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const FaIcon(
                                FontAwesomeIcons.cartShopping,
                              );
                            },
                          ),
                          label: 'Keranjang',
                        ),
                        const BottomNavigationBarItem(
                          icon: FaIcon(FontAwesomeIcons.solidUser),
                          label: 'Profil',
                        ),
                      ],
                    );
                  },
                )
              : null,
          child: SafeArea(
            child: canOrder
                ? PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      MenuPageView(
                        name: event.name,
                        pickupNote: event.pickupNote,
                        startAt: event.startAt!,
                        endAt: event.endAt!,
                      ),
                      CartPageView(key: UniqueKey()),
                      const CustomerProfilePageView(),
                    ],
                  )
                : BackgroundContainer(
                    child: appText.header('Bazar belum dimulai.'),
                  ),
          ),
        );
      },
    );
  }
}
