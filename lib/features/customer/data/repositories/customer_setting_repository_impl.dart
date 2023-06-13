import 'package:online_bazaar/features/customer/data/data_sources/customer_setting_data_source.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_setting_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

class CustomerSettingRepositoryImpl implements CustomerSettingRepository {
  final CustomerSettingDataSource _dataSource;

  const CustomerSettingRepositoryImpl({
    required CustomerSettingDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Stream<Setting> getSetting() {
    return _dataSource.getSetting();
  }
}
