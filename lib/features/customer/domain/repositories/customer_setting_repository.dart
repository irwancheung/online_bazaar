import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

abstract class CustomerSettingRepository {
  Stream<Setting> getSetting();
}
