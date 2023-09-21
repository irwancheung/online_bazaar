import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/firebase_options.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final auth = sl<FirebaseAuth>();
  final firestore = sl<FirebaseFirestore>();
  final storage = sl<FirebaseStorage>();

// TODO: Uncomment kalau akan menggunakan remote config
  // final remoteConfig = sl<FirebaseRemoteConfig>();

  // remoteConfig.setConfigSettings(
  //   RemoteConfigSettings(
  //     fetchTimeout: const Duration(minutes: 1),
  //     minimumFetchInterval: const Duration(minutes: 60),
  //   ),
  // );

  if (const bool.fromEnvironment('USE_FIREBASE_EMULATOR')) {
    await auth.useAuthEmulator('localhost', 9099);
    firestore.useFirestoreEmulator('localhost', 8080);
    storage.useStorageEmulator('localhost', 9199);
  }
}
