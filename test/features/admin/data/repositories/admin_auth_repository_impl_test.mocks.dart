// Mocks generated by Mockito 5.4.1 from annotations
// in online_bazaar/test/features/admin/data/repositories/admin_auth_repository_impl_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:online_bazaar/core/network_info.dart' as _i3;
import 'package:online_bazaar/features/admin/data/data_sources/admin_auth_data_source.dart'
    as _i5;
import 'package:online_bazaar/features/admin/data/models/admin_model.dart'
    as _i2;
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart'
    as _i6;

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

class _FakeAdminModel_0 extends _i1.SmartFake implements _i2.AdminModel {
  _FakeAdminModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> checkConnection() => (super.noSuchMethod(
        Invocation.method(
          #checkConnection,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [AdminAuthDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminAuthDataSource extends _i1.Mock
    implements _i5.AdminAuthDataSource {
  @override
  _i4.Future<_i2.AdminModel> logIn(_i6.LoginParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [params],
        ),
        returnValue: _i4.Future<_i2.AdminModel>.value(_FakeAdminModel_0(
          this,
          Invocation.method(
            #logIn,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.AdminModel>.value(_FakeAdminModel_0(
          this,
          Invocation.method(
            #logIn,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.AdminModel>);
  @override
  bool isLoggedIn() => (super.noSuchMethod(
        Invocation.method(
          #isLoggedIn,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<void> logOut() => (super.noSuchMethod(
        Invocation.method(
          #logOut,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
