import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

part 'admin_setting_state.dart';

class AdminSettingCubit extends HydratedCubit<AdminSettingState> {
  final AdminSettingRepository _repository;
  AdminSettingCubit({
    required AdminSettingRepository repository,
  })  : _repository = repository,
        super(AdminSettingState(setting: SettingModel.newSetting()));

  Future<void> getSetting() async {
    try {
      emit(GetSettingLoadingState(setting: state.setting));

      final setting = await _repository.getSetting();

      emit(GetSettingSuccessState(setting: setting));
    } on AppException catch (e) {
      emit(
        GetSettingFailureState(
          setting: state.setting,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> updateSetting(UpdateSettingsParams params) async {
    try {
      emit(UpdateSettingLoadingState(setting: state.setting));

      final setting = await _repository.updateSetting(params);

      emit(UpdateSettingSuccessState(setting: setting));
    } on AppException catch (e) {
      emit(
        UpdateSettingFailureState(
          setting: state.setting,
          errorMessage: e.message,
        ),
      );
    }
  }

  @override
  AdminSettingState? fromJson(Map<String, dynamic> json) {
    try {
      return AdminSettingState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AdminSettingState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
