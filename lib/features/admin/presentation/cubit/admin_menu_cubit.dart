import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

part 'admin_menu_state.dart';

class AdminMenuCubit extends HydratedCubit<AdminMenuState> {
  final AdminMenuRepository _repository;

  StreamSubscription? _itemsSubscription;

  AdminMenuCubit({required AdminMenuRepository repository})
      : _repository = repository,
        super(const AdminMenuState(menuItems: []));

  void getMenuItems() {
    emit(GetMenuItemsLoadingState(menuItems: state.menuItems));

    _itemsSubscription?.cancel();

    _itemsSubscription = _repository.getMenuItems().listen((items) {
      emit(GetMenuItemsSuccessState(menuItems: items));
    });

    _itemsSubscription?.onError((e) {
      logger.error(e.toString(), StackTrace.current);
      emit(
        GetMenuItemsFailureState(
          menuItems: state.menuItems,
          errorMessage: 'Gagal memuat menu.',
        ),
      );
    });
  }

  Future<void> addMenuItem(AddMenuItemParams params) async {
    try {
      emit(AddMenuItemLoadingState(menuItems: state.menuItems));

      final menuItem = await _repository.addMenuItem(params);

      emit(
        AddMenuItemSuccessState(
          menuItem: menuItem,
          menuItems: state.menuItems,
        ),
      );
    } on AppException catch (e) {
      emit(
        AddMenuItemFailureState(
          menuItems: state.menuItems,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> updateMenuItem(UpdateMenuItemParams params) async {
    try {
      emit(UpdateMenuItemLoadingState(menuItems: state.menuItems));

      final menuItem = await _repository.updateMenuItem(params);

      emit(
        UpdateMenuItemSuccessState(
          menuItem: menuItem,
          menuItems: state.menuItems,
        ),
      );
    } on AppException catch (e) {
      emit(
        UpdateMenuItemFailureState(
          menuItems: state.menuItems,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> setMenuItemVisibility(SetMenuItemVisibilityParams params) async {
    try {
      emit(SetMenuItemVisibilityLoadingState(menuItems: state.menuItems));

      final menuItem = await _repository.setMenuItemVisibility(params);

      emit(
        SetMenuItemVisibilitySuccessState(
          menuItem: menuItem,
          menuItems: state.menuItems,
        ),
      );
    } on AppException catch (e) {
      emit(
        SetMenuItemVisibilityFailureState(
          menuItems: state.menuItems,
          errorMessage: e.message,
        ),
      );
    }
  }

  void cancelSubscription() {
    _itemsSubscription?.cancel();
  }

  @override
  Future<void> close() {
    cancelSubscription();
    return super.close();
  }

  @override
  AdminMenuState? fromJson(Map<String, dynamic> json) {
    try {
      return AdminMenuState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AdminMenuState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
