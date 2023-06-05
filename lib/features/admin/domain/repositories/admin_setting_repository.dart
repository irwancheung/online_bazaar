import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';

abstract class AdminSettingRepository {
  Future<Setting> getSetting();
  Future<Setting> updateSetting(UpdateSettingsParams params);
}

class UpdateSettingsParams extends Equatable {
  final String eventName;
  final String eventPickupNote;
  final DateTime eventStartAt;
  final DateTime eventEndAt;
  final String orderNumberPrefix;
  final String transferTo;
  final String transferNoteFormat;
  final String sendTransferProofTo;

  const UpdateSettingsParams({
    required this.eventName,
    required this.eventPickupNote,
    required this.eventStartAt,
    required this.eventEndAt,
    required this.orderNumberPrefix,
    required this.transferTo,
    required this.transferNoteFormat,
    required this.sendTransferProofTo,
  });

  @override
  List<Object?> get props => [
        eventName,
        eventPickupNote,
        eventStartAt,
        eventEndAt,
        orderNumberPrefix,
        transferTo,
        transferNoteFormat,
        sendTransferProofTo,
      ];
}
