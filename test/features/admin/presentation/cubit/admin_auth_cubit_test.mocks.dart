// Mocks generated by Mockito 5.4.1 from annotations
// in online_bazaar/test/features/admin/presentation/cubit/admin_auth_cubit_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:online_bazaar/features/admin/domain/entities/admin.dart' as _i2;
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart'
    as _i3;

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

class _FakeAdmin_0 extends _i1.SmartFake implements _i2.Admin {
  _FakeAdmin_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdminAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminAuthRepository extends _i1.Mock
    implements _i3.AdminAuthRepository {
  @override
  _i4.Future<_i2.Admin> logIn(_i3.LoginParams? params) => (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [params],
        ),
        returnValue: _i4.Future<_i2.Admin>.value(_FakeAdmin_0(
          this,
          Invocation.method(
            #logIn,
            [params],
          ),
        )),
        returnValueForMissingStub: _i4.Future<_i2.Admin>.value(_FakeAdmin_0(
          this,
          Invocation.method(
            #logIn,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.Admin>);
  @override
  _i4.Future<bool> isLoggedIn() => (super.noSuchMethod(
        Invocation.method(
          #isLoggedIn,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
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
