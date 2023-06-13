import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

part 'customer_setting_state.dart';

class CustomerSettingCubit extends HydratedCubit<CustomerSettingState> {
  final CustomerSettingRepository _repository;

  StreamSubscription? _itemsSubscription;

  CustomerSettingCubit({required CustomerSettingRepository repository})
      : _repository = repository,
        super(const CustomerSettingState());

  void getSetting() {
    emit(GetSettingLoadingState(setting: state.setting));

    _itemsSubscription?.cancel();

    _itemsSubscription = _repository.getSetting().listen((setting) {
      emit(GetSettingSuccessState(setting: setting));
    });

    _itemsSubscription?.onError((e) {
      logger.error(e.toString(), StackTrace.current);
      emit(
        GetSettingFailureState(
          setting: state.setting,
          errorMessage: 'Gagal memuat pengatura.',
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
  CustomerSettingState? fromJson(Map<String, dynamic> json) {
    try {
      return CustomerSettingState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CustomerSettingState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
