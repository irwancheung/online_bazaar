import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/features/admin/data/models/admin_model.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';

part 'admin_auth_state.dart';

class AdminAuthCubit extends HydratedCubit<AdminAuthState> {
  final AdminAuthRepository _repository;

  AdminAuthCubit({required AdminAuthRepository repository})
      : _repository = repository,
        super(const AdminAuthState());

  Future<void> logIn(LoginParams params) async {
    try {
      emit(const LoginLoadingState());

      final admin = await _repository.logIn(params);

      emit(LoginSuccessState(admin: admin));
    } on AppException catch (e) {
      emit(LoginFailureState(errorMessage: e.message));
    }
  }

  Future<void> logOut() async {
    try {
      emit(const LogoutLoadingState());

      await _repository.logOut();

      emit(const LogoutSuccessState());
    } on AppException catch (e) {
      emit(LogoutFailureState(errorMessage: e.message));
    }
  }

  @override
  AdminAuthState? fromJson(Map<String, dynamic> json) {
    try {
      return AdminAuthState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AdminAuthState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
