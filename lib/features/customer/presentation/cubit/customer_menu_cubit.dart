import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_menu_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

part 'customer_menu_state.dart';

class CustomerMenuCubit extends HydratedCubit<CustomerMenuState> {
  final CustomerMenuRepository _repository;

  StreamSubscription? _itemsSubscription;

  CustomerMenuCubit({required CustomerMenuRepository repository})
      : _repository = repository,
        super(const CustomerMenuState(menuItems: []));

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

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }

  @override
  CustomerMenuState? fromJson(Map<String, dynamic> json) {
    try {
      return CustomerMenuState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CustomerMenuState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
