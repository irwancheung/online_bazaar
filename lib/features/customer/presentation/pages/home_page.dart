import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/pages/cart_page_view.dart';
import 'package:online_bazaar/features/customer/presentation/pages/customer_profile_page_view.dart';
import 'package:online_bazaar/features/customer/presentation/pages/menu_page_view.dart';
import 'package:online_bazaar/features/shared/presentation/cubit/config_cubit.dart';
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
    context.read<ConfigCubit>().fetchConfig();
  }

  void _changePage(int index) {
    _activeIndex.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        final event = state.event;
        final now = DateTime.now();
        final canOrder =
            now.isAfter(event.startAt) && now.isBefore(event.endAt);

        return Scaffold(
          body: SafeArea(
            child: canOrder
                ? PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      MenuPageView(
                        title: event.title,
                        pickupNote: event.pickupNote,
                        startAt: event.startAt,
                        endAt: event.endAt,
                      ),
                      CartPageView(key: UniqueKey()),
                      const CustomerProfilePageView(),
                    ],
                  )
                : BackgroundContainer(
                    child: appText.header('Bazar belum dimulai.'),
                  ),
          ),
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
                                  alignment: Alignment.topCenter,
                                  children: [
                                    SizedBox(
                                      width: 35.r,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.cartShopping,
                                    ),
                                    Positioned(
                                      left: 25,
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
        );
      },
    );
  }
}
