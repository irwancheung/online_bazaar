import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_bazaar/core/logger.dart';

class MockStorage extends Mock implements Storage {}

Future<void> initHelpersTest() async {
  await _initServiceLocatorTest();
  _initHydratedBlocTest();
}

Future<void> _initServiceLocatorTest() async {
  final sl = GetIt.instance;
  sl.registerLazySingleton(() => Logger());
}

void _initHydratedBlocTest() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final storage = MockStorage();

  when(
    () => storage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {});

  HydratedBloc.storage = storage;
}

String fixture(String name) => File('test/mock_data/$name').readAsStringSync();
