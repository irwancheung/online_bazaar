import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/app_bloc_observer.dart';
import 'package:online_bazaar/core/firebase.dart';
import 'package:online_bazaar/core/localizations/form_builder_localizations_id.dart';
import 'package:online_bazaar/core/router.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_auth_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_food_order_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_menu_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/cubit/config_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.tracesSampleRate = 1.0;
    },
    appRunner: () async {
      FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
      );

      await _initRequiredPlugins();
      runApp(const MyApp());

      FlutterNativeSplash.remove();
    },
  );
}

Future<void> _initRequiredPlugins() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initServiceLocator();
  await initFirebase();

  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ConfigCubit>()),
        if (const String.fromEnvironment('USER_TYPE') == 'admin') ...[
          BlocProvider(create: (context) => sl<AdminAuthCubit>()),
          BlocProvider(create: (context) => sl<AdminMenuCubit>()),
          BlocProvider(create: (context) => sl<AdminFoodOrderCubit>()),
        ] else ...[
          BlocProvider(create: (context) => sl<CustomerCubit>()),
          BlocProvider(create: (context) => sl<CustomerMenuCubit>()),
          BlocProvider(create: (context) => sl<CustomerCartCubit>()),
          BlocProvider(create: (context) => sl<CustomerFoodOrderCubit>()),
        ],
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return child!;
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Bazar Online',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          locale: const Locale('id'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            FormBuilderLocalizationsId.delegate,
            FormBuilderLocalizationsDelegate(),
          ],
          supportedLocales: FormBuilderLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
  }
}
