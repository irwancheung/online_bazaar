// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_auth_cubit.dart';

class AdminAuthState extends Equatable {
  final Admin? admin;
  final String? errorMessage;

  const AdminAuthState({
    this.admin,
    this.errorMessage,
  });

  AdminAuthState copyWith({
    Admin? admin,
    bool? isLoggedIn,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AdminAuthState(
      admin: admin ?? this.admin,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'admin': admin != null ? AdminModel.fromEntity(admin!).toMap() : null,
      'errorMessage': errorMessage,
    };
  }

  factory AdminAuthState.fromMap(Map<String, dynamic> map) {
    return AdminAuthState(
      admin: map['admin'] != null
          ? AdminModel.fromMap(map['admin'] as Map<String, dynamic>)
          : null,
      errorMessage: map['errorMessage'] as String?,
    );
  }

  @override
  List<Object?> get props => [admin, errorMessage];
}

class LoginLoadingState extends AdminAuthState {
  const LoginLoadingState();
}

class LoginSuccessState extends AdminAuthState {
  const LoginSuccessState({super.admin});
}

class LoginFailureState extends AdminAuthState {
  const LoginFailureState({super.errorMessage});
}

class LogoutLoadingState extends AdminAuthState {
  const LogoutLoadingState();
}

class LogoutSuccessState extends AdminAuthState {
  const LogoutSuccessState();
}

class LogoutFailureState extends AdminAuthState {
  const LogoutFailureState({super.errorMessage});
}
