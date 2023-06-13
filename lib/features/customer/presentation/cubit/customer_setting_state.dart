part of 'customer_setting_cubit.dart';

class CustomerSettingState extends Equatable {
  final Setting? setting;
  final String? errorMessage;

  const CustomerSettingState({
    this.setting,
    this.errorMessage,
  });

  factory CustomerSettingState.fromMap(Map<String, dynamic> map) {
    return CustomerSettingState(
      setting: map['setting'] != null
          ? SettingModel.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      errorMessage: map['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting':
          setting != null ? SettingModel.fromEntity(setting!).toMap() : null,
      'errorMessage': errorMessage,
    };
  }

  @override
  List<Object?> get props => [setting, errorMessage];
}

class GetSettingLoadingState extends CustomerSettingState {
  const GetSettingLoadingState({required super.setting});
}

class GetSettingSuccessState extends CustomerSettingState {
  const GetSettingSuccessState({required super.setting});
}

class GetSettingFailureState extends CustomerSettingState {
  const GetSettingFailureState({
    required super.setting,
    required super.errorMessage,
  });
}
