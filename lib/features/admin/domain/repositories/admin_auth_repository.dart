import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';

abstract class AdminAuthRepository {
  Future<Admin> logIn(LoginParams params);
  Future<bool> isLoggedIn();
  Future<void> logOut();
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
