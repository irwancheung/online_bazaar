import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/core/exceptions/setting_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/shared/data/models/event_setting_model.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_setting_model.dart';
import 'package:online_bazaar/features/shared/data/models/payment_setting_model.dart';
import 'package:online_bazaar/features/shared/data/models/setting_model.dart';

class AdminSettingDataSource {
  final FirebaseFirestore _firestore;

  const AdminSettingDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<SettingModel> getSetting() async {
    try {
      final settingSnapshots = await _settingRef.get();

      if (settingSnapshots.docs.isEmpty) {
        return SettingModel.newSetting();
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
      final eventSetting = EventSettingModel(
        name: params.eventName,
        pickupNote: params.eventPickupNote,
        startAt: params.eventStartAt,
        endAt: params.eventEndAt,
      );

      final foodOrderSetting = FoodOrderSettingModel(
        orderNumberPrefix: params.orderNumberPrefix,
      );

      final paymentSetting = PaymentSettingModel(
        transferTo: params.transferTo,
        transferNoteFormat: params.transferNoteFormat,
        sendTransferProofTo: params.sendTransferProofTo,
      );

      final settingSnapshots = await _settingRef.get();

      if (settingSnapshots.docs.isEmpty) {
        final now = DateTime.now();

        final newSetting = SettingModel(
          id: now.toString(),
          event: eventSetting,
          foodOrder: foodOrderSetting,
          payment: paymentSetting,
          createdAt: now,
        );

        final docRef = await _settingRef.add(newSetting.toMap());
        final id = docRef.id;

        await _settingRef.doc(id).update({'id': id});
        final settingSnapshot = await _settingRef.doc(id).get();

        return SettingModel.fromMap(settingSnapshot.data()!);
      }

      final settingDoc = settingSnapshots.docs.first;

      await settingDoc.reference.update({
        'event': eventSetting.toMap(),
        'foodOrder': foodOrderSetting.toMap(),
        'payment': paymentSetting.toMap(),
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });

      final updatedSettingDoc = await settingDoc.reference.get();

      return SettingModel.fromMap(updatedSettingDoc.data()!);
    } catch (e, s) {
      logger.error(e, s);
      throw const UpdateSettingException();
    }
  }

  CollectionReference<Map<String, dynamic>> get _settingRef =>
      _firestore.collection('settings');
}
