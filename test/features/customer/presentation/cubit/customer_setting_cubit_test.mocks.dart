// Mocks generated by Mockito 5.4.1 from annotations
// in online_bazaar/test/features/customer/presentation/cubit/customer_setting_cubit_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:online_bazaar/features/customer/domain/repositories/customer_setting_repository.dart'
    as _i2;
import 'package:online_bazaar/features/shared/domain/entities/setting.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CustomerSettingRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomerSettingRepository extends _i1.Mock
    implements _i2.CustomerSettingRepository {
  @override
  _i3.Stream<_i4.Setting> getSetting() => (super.noSuchMethod(
        Invocation.method(
          #getSetting,
          [],
        ),
        returnValue: _i3.Stream<_i4.Setting>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.Setting>.empty(),
      ) as _i3.Stream<_i4.Setting>);
}
