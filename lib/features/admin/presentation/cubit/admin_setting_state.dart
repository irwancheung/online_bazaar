part of 'admin_setting_cubit.dart';

class AdminSettingState extends Equatable {
  final Setting setting;
  final String? errorMessage;

  const AdminSettingState({
    required this.setting,
    this.errorMessage,
  });

  AdminSettingState copyWith({Setting? setting}) {
    return AdminSettingState(setting: setting ?? this.setting);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': SettingModel.fromEntity(setting).toMap(),
    };
  }

  factory AdminSettingState.fromMap(Map<String, dynamic> map) {
    return AdminSettingState(
      setting: SettingModel.fromMap(map['setting'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [setting];
}

class GetSettingLoadingState extends AdminSettingState {
  const GetSettingLoadingState({required super.setting});
}

class GetSettingSuccessState extends AdminSettingState {
  const GetSettingSuccessState({required super.setting});
}

class GetSettingFailureState extends AdminSettingState {
  const GetSettingFailureState({
    required super.setting,
    required super.errorMessage,
  });
}

class UpdateSettingLoadingState extends AdminSettingState {
  const UpdateSettingLoadingState({required super.setting});
}

class UpdateSettingSuccessState extends AdminSettingState {
  const UpdateSettingSuccessState({required super.setting});
}

class UpdateSettingFailureState extends AdminSettingState {
  const UpdateSettingFailureState({
    required super.setting,
    required super.errorMessage,
  });
}
