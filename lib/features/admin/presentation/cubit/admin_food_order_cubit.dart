import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

part 'admin_food_order_state.dart';

class AdminFoodOrderCubit extends HydratedCubit<AdminFoodOrderState> {
  final AdminFoodOrderRepository _repository;

  StreamSubscription? _foodOrdersSubscription;

  AdminFoodOrderCubit({required AdminFoodOrderRepository repository})
      : _repository = repository,
        super(const AdminFoodOrderState(foodOrders: []));

  void getFoodOrders() {
    emit(GetFoodOrdersLoadingState(foodOrders: state.foodOrders));

    _foodOrdersSubscription?.cancel();

    _foodOrdersSubscription = _repository.getFoodOrders().listen((foodOrders) {
      emit(GetFoodOrdersSuccessState(foodOrders: foodOrders));
    });

    _foodOrdersSubscription?.onError((e) {
      logger.error(e.toString(), StackTrace.current);
      emit(
        GetFoodOrdersFailureState(
          foodOrders: state.foodOrders,
          errorMessage: 'Gagal memuat pesanan',
        ),
      );
    });
  }

  Future<void> updateFoodOrderStatus(UpdateFoodOrderStatusParams params) async {
    try {
      emit(UpdateFoodOrderStatusLoadingState(foodOrders: state.foodOrders));

      final foodOrder = await _repository.updateFoodOrderStatus(params);

      emit(
        UpdateFoodOrderStatusSuccessState(
          foodOrder: foodOrder,
          foodOrders: state.foodOrders,
        ),
      );
    } on AppException catch (e) {
      emit(
        UpdateFoodOrderStatusFailureState(
          foodOrders: state.foodOrders,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> updateAdminNote(UpdateAdminNoteParams params) async {
    try {
      emit(UpdateAdminNoteLoadingState(foodOrders: state.foodOrders));

      final foodOrder = await _repository.updateAdminNote(params);

      emit(
        UpdateAdminNoteSuccessState(
          foodOrder: foodOrder,
          foodOrders: state.foodOrders,
        ),
      );
    } on AppException catch (e) {
      emit(
        UpdateAdminNoteFailureState(
          foodOrders: state.foodOrders,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> exportFoodOrdersToSheetFile(
    ExportFoodOrdersToSheetFileParams params,
  ) async {
    try {
      emit(
        ExportFoodOrdersToSheetFileLoadingState(
          foodOrders: state.foodOrders,
        ),
      );

      await _repository.exportFoodOrdersToSheetFile(params);

      emit(
        ExportFoodOrdersToSheetFileSuccessState(
          foodOrders: state.foodOrders,
        ),
      );
    } on AppException catch (e) {
      emit(
        ExportFoodOrdersToSheetFileFailureState(
          foodOrders: state.foodOrders,
          errorMessage: e.message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _foodOrdersSubscription?.cancel();
    return super.close();
  }

  @override
  AdminFoodOrderState? fromJson(Map<String, dynamic> json) {
    try {
      return AdminFoodOrderState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AdminFoodOrderState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
