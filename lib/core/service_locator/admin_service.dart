import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_auth_data_source.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_food_order_data_source.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_menu_data_source.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_setting_data_source.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_auth_repository_impl.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_food_order_repository_impl.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_menu_repository_impl.dart';
import 'package:online_bazaar/features/admin/data/repositories/admin_setting_repository_impl.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_auth_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';

Future<void> initAdminService() async {
  //! Cubit
  sl.registerFactory(() => AdminAuthCubit(repository: sl()));
  sl.registerFactory(() => AdminMenuCubit(repository: sl()));
  sl.registerFactory(() => AdminFoodOrderCubit(repository: sl()));
  sl.registerFactory(() => AdminSettingCubit(repository: sl()));

  //! Repository
  sl.registerLazySingleton<AdminAuthRepository>(
    () => AdminAuthRepositoryImpl(networkInfo: sl(), dataSource: sl()),
  );

  sl.registerLazySingleton<AdminMenuRepository>(
    () => AdminMenuRepositoryImpl(networkInfo: sl(), dataSource: sl()),
  );

  sl.registerLazySingleton<AdminFoodOrderRepository>(
    () => AdminFoodOrderRepositoryImpl(
      networkInfo: sl(),
      dataSource: sl(),
      sheetGenerator: sl(),
    ),
  );

  sl.registerLazySingleton<AdminSettingRepository>(
    () => AdminSettingRepositoryImpl(networkInfo: sl(), dataSource: sl()),
  );

  //! Data Source
  sl.registerLazySingleton(() => AdminAuthDataSource(auth: sl()));
  sl.registerLazySingleton(
    () => AdminMenuDataSource(firestore: sl(), storage: sl()),
  );
  sl.registerLazySingleton(() => AdminFoodOrderDataSource(firestore: sl()));
  sl.registerLazySingleton(() => AdminSettingDataSource(firestore: sl()));
}
