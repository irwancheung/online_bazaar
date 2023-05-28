import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_cart_data_source.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_menu_data_source.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_cart_repository_impl.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_food_order_repository_impl.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_menu_repository_impl.dart';
import 'package:online_bazaar/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_menu_repository.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_food_order_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_menu_cubit.dart';

Future<void> initCustomerService() async {
  //! Cubit
  sl.registerFactory(() => CustomerCubit(repository: sl()));
  sl.registerFactory(() => CustomerMenuCubit(repository: sl()));
  sl.registerFactory(() => CustomerCartCubit(repository: sl()));
  sl.registerFactory(() => CustomerFoodOrderCubit(repository: sl()));

  //! Repository
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl());

  sl.registerLazySingleton<CustomerMenuRepository>(
    () => CustomerMenuRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<CustomerCartRepository>(
    () => CustomerCartRepositoryImpl(
      networkInfo: sl(),
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CustomerFoodOrderRepository>(
    () => CustomerFoodOrderRepositoryImpl(screenshotController: sl()),
  );

  //! Data Source
  sl.registerLazySingleton(() => CustomerMenuDataSource(firestore: sl()));
  sl.registerLazySingleton(() => CustomerCartDataSource(firestore: sl()));
}
