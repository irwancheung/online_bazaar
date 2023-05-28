// Mocks generated by Mockito 5.4.1 from annotations
// in online_bazaar/test/features/admin/presentation/cubit/admin_menu_cubit_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart'
    as _i3;
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart'
    as _i2;

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

class _FakeMenuItem_0 extends _i1.SmartFake implements _i2.MenuItem {
  _FakeMenuItem_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdminMenuRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminMenuRepository extends _i1.Mock
    implements _i3.AdminMenuRepository {
  @override
  _i4.Stream<List<_i2.MenuItem>> getMenuItems() => (super.noSuchMethod(
        Invocation.method(
          #getMenuItems,
          [],
        ),
        returnValue: _i4.Stream<List<_i2.MenuItem>>.empty(),
        returnValueForMissingStub: _i4.Stream<List<_i2.MenuItem>>.empty(),
      ) as _i4.Stream<List<_i2.MenuItem>>);
  @override
  _i4.Future<_i2.MenuItem> addMenuItem(_i3.AddMenuItemParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMenuItem,
          [params],
        ),
        returnValue: _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #addMenuItem,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #addMenuItem,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.MenuItem>);
  @override
  _i4.Future<_i2.MenuItem> updateMenuItem(_i3.UpdateMenuItemParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateMenuItem,
          [params],
        ),
        returnValue: _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #updateMenuItem,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #updateMenuItem,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.MenuItem>);
  @override
  _i4.Future<_i2.MenuItem> setMenuItemVisibility(
          _i3.SetMenuItemVisibilityParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #setMenuItemVisibility,
          [params],
        ),
        returnValue: _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #setMenuItemVisibility,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.MenuItem>.value(_FakeMenuItem_0(
          this,
          Invocation.method(
            #setMenuItemVisibility,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.MenuItem>);
}