import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_setting_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

class AdminSettingRepositoryImpl implements AdminSettingRepository {
  final NetworkInfo _networkInfo;
  final AdminSettingDataSource _dataSource;

  AdminSettingRepositoryImpl({
    required NetworkInfo networkInfo,
    required AdminSettingDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  @override
  Future<Setting> getSetting() async {
    try {
      await _networkInfo.checkConnection();

      final setting = await _dataSource.getSetting();

      return setting;
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const GetSettingException();
    }
  }

  @override
  Future<Setting> updateSetting(UpdateSettingsParams params) async {
    try {
      await _networkInfo.checkConnection();

      final newSetting = await _dataSource.updateSetting(params);

      return newSetting;
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const UpdateSettingException();
    }
  }
}
