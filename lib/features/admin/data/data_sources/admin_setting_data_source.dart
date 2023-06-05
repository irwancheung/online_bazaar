import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';

class AdminSettingDataSource {
  final FirebaseFirestore _firestore;

  const AdminSettingDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<SettingModel> getSetting() async {
    try {
      final settingSnapshots = await _settingRef.get();

      if (settingSnapshots.docs.isEmpty) {
        return SettingModel.empty();
      }

      final settingDoc = settingSnapshots.docs.first;

      return SettingModel.fromMap(settingDoc.data());
    } catch (e, s) {
      logger.error(e, s);
      throw const GetSettingException();
    }
  }

  Future<SettingModel> updateSetting(UpdateSettingsParams params) async {
    try {
      final settingSnapshots = await _settingRef.get();

      if (settingSnapshots.docs.isEmpty) {
        final newSetting = SettingModel.fromUpdateSettingParams(params);

        await _settingRef.add(newSetting.toMap());

        return newSetting;
      }

      final settingDoc = settingSnapshots.docs.first;

      final updatedSetting = SettingModel.fromUpdateSettingParams(params);

      await settingDoc.reference.update(updatedSetting.toMap());

      return updatedSetting;
    } catch (e, s) {
      logger.error(e, s);
      throw const UpdateSettingException();
    }
  }

  CollectionReference<Map<String, dynamic>> get _settingRef =>
      _firestore.collection('settings');
}
