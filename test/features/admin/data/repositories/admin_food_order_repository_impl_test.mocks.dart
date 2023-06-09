// Mocks generated by Mockito 5.4.1 from annotations
// in online_bazaar/test/features/admin/data/repositories/admin_food_order_repository_impl_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:excel/excel.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:online_bazaar/core/generators/sheet_generator.dart' as _i8;
import 'package:online_bazaar/core/network_info.dart' as _i4;
import 'package:online_bazaar/features/admin/data/data_sources/admin_food_order_data_source.dart'
    as _i6;
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart'
    as _i7;
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart'
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

class _FakeFoodOrderModel_0 extends _i1.SmartFake
    implements _i2.FoodOrderModel {
  _FakeFoodOrderModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExcel_1 extends _i1.SmartFake implements _i3.Excel {
  _FakeExcel_1(
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
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  @override
  _i5.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i5.Future<bool>.value(false),
        returnValueForMissingStub: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<void> checkConnection() => (super.noSuchMethod(
        Invocation.method(
          #checkConnection,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [AdminFoodOrderDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminFoodOrderDataSource extends _i1.Mock
    implements _i6.AdminFoodOrderDataSource {
  @override
  _i5.Stream<List<_i2.FoodOrderModel>> getFoodOrders() => (super.noSuchMethod(
        Invocation.method(
          #getFoodOrders,
          [],
        ),
        returnValue: _i5.Stream<List<_i2.FoodOrderModel>>.empty(),
        returnValueForMissingStub: _i5.Stream<List<_i2.FoodOrderModel>>.empty(),
      ) as _i5.Stream<List<_i2.FoodOrderModel>>);
  @override
  _i5.Future<_i2.FoodOrderModel> updateFoodOrderStatus(
          _i7.UpdateFoodOrderStatusParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateFoodOrderStatus,
          [params],
        ),
        returnValue: _i5.Future<_i2.FoodOrderModel>.value(_FakeFoodOrderModel_0(
          this,
          Invocation.method(
            #updateFoodOrderStatus,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.FoodOrderModel>.value(_FakeFoodOrderModel_0(
          this,
          Invocation.method(
            #updateFoodOrderStatus,
            [params],
          ),
        )),
      ) as _i5.Future<_i2.FoodOrderModel>);
  @override
  _i5.Future<_i2.FoodOrderModel> updateAdminNote(
          _i7.UpdateAdminNoteParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateAdminNote,
          [params],
        ),
        returnValue: _i5.Future<_i2.FoodOrderModel>.value(_FakeFoodOrderModel_0(
          this,
          Invocation.method(
            #updateAdminNote,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.FoodOrderModel>.value(_FakeFoodOrderModel_0(
          this,
          Invocation.method(
            #updateAdminNote,
            [params],
          ),
        )),
      ) as _i5.Future<_i2.FoodOrderModel>);
}

/// A class which mocks [SheetGenerator].
///
/// See the documentation for Mockito's code generation for more information.
class MockSheetGenerator extends _i1.Mock implements _i8.SheetGenerator {
  @override
  _i3.Excel newSheet() => (super.noSuchMethod(
        Invocation.method(
          #newSheet,
          [],
        ),
        returnValue: _FakeExcel_1(
          this,
          Invocation.method(
            #newSheet,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeExcel_1(
          this,
          Invocation.method(
            #newSheet,
            [],
          ),
        ),
      ) as _i3.Excel);
  @override
  _i5.Future<void> save(_i3.Excel? sheet) => (super.noSuchMethod(
        Invocation.method(
          #save,
          [sheet],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
