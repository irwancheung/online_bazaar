import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/pages/food_order_page_view.dart';
import 'package:online_bazaar/features/admin/presentation/pages/logout_page_view.dart';
import 'package:online_bazaar/features/admin/presentation/pages/menu_page_view.dart';
import 'package:online_bazaar/features/admin/presentation/pages/setting_page_view.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_scaffold.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _activeIndex = ValueNotifier<int>(0);
  final _pageController = PageController();

  void _changePage(int index) {
    _activeIndex.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _activeIndex,
        builder: (context, index, child) {
          return BottomNavigationBar(
            showSelectedLabels: true,
            currentIndex: _activeIndex.value,
            onTap: _changePage,
            selectedLabelStyle: TextStyle(fontSize: 12.sp),
            unselectedLabelStyle: TextStyle(fontSize: 10.sp),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bowlFood),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.listCheck),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.gear),
                label: 'Pengaturan',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.rightFromBracket),
                label: 'Keluar',
              ),
            ],
          );
        },
      ),
      child: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MenuPageView(),
            FoodOrderPageView(),
            SettingPageView(),
            LogOutPageView(),
          ],
        ),
      ),
    );
  }
}
