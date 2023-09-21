import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:online_bazaar/core/constants/route_const.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/presentation/pages/admin_page.dart';
import 'package:online_bazaar/features/admin/presentation/pages/login_page.dart';
import 'package:online_bazaar/features/customer/presentation/pages/home_page.dart';

final router = const String.fromEnvironment('USER_TYPE') == 'admin' ? _adminRouter : _customerRouter;

final _customerRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

final _adminRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: adminPage,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AdminPage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'menu',
          builder: (context, state) => const AdminPage(),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final location = state.fullPath ?? '';

    final auth = sl<FirebaseAuth>();
    final loggedIn = auth.currentUser != null;

    if (!location.contains('login') && !loggedIn) {
      return adminLoginPage;
    }

    if (location.contains('login') && loggedIn) {
      return adminPage;
    }

    return null;
  },
);
