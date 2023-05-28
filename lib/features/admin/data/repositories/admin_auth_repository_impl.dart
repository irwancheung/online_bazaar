import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/auth_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_auth_data_source.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';

class AdminAuthRepositoryImpl implements AdminAuthRepository {
  final NetworkInfo _networkInfo;
  final AdminAuthDataSource _dataSource;

  AdminAuthRepositoryImpl({
    required NetworkInfo networkInfo,
    required AdminAuthDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  @override
  Future<Admin> logIn(LoginParams params) async {
    try {
      await _networkInfo.checkConnection();

      return await _dataSource.logIn(params);
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const LoginException();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      await _networkInfo.checkConnection();

      return _dataSource.isLoggedIn();
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e);
      throw const LoginStatusCheckException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _networkInfo.checkConnection();

      return await _dataSource.logOut();
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e);
      throw const LogoutException();
    }
  }
}
