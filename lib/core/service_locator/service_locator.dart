import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:online_bazaar/core/app_text.dart';
import 'package:online_bazaar/core/generators/sheet_generator.dart';
import 'package:online_bazaar/core/logger.dart';
import 'package:online_bazaar/core/network_info.dart';

import 'package:online_bazaar/core/service_locator/admin_service.dart';
import 'package:online_bazaar/core/service_locator/customer_service.dart';
import 'package:screenshot/screenshot.dart';

final sl = GetIt.instance;
final logger = sl<Logger>();
final appText = sl<AppText>();

Future<void> initServiceLocator() async {
  initAdminService();
  initCustomerService();

  //! Core
  sl.registerLazySingleton(() => Logger());
  sl.registerLazySingleton(() => AppText());
  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => SheetGenerator());

  //! External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  sl.registerLazySingleton(() => ScreenshotController());
}
