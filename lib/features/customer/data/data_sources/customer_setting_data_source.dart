import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';

class CustomerSettingDataSource {
  final FirebaseFirestore _firestore;

  const CustomerSettingDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<SettingModel> getSetting() {
    return _settingRef
        .snapshots()
        .map((snapshot) => SettingModel.fromMap(snapshot.docs[0].data()));
  }

  CollectionReference<Map<String, dynamic>> get _settingRef =>
      _firestore.collection('settings');
}
