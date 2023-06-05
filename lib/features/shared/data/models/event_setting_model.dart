import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';

class EventSettingModel extends EventSetting {
  const EventSettingModel({
    required super.name,
    required super.pickupNote,
    super.startAt,
    super.endAt,
  });

  factory EventSettingModel.fromEntity(EventSetting eventSetting) {
    return EventSettingModel(
      name: eventSetting.name,
      pickupNote: eventSetting.pickupNote,
      startAt: eventSetting.startAt,
      endAt: eventSetting.endAt,
    );
  }

  EventSetting copyWith({
    String? name,
    String? pickupNote,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return EventSetting(
      name: name ?? this.name,
      pickupNote: pickupNote ?? this.pickupNote,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'pickupNote': pickupNote,
      'startAt': startAt?.millisecondsSinceEpoch,
      'endAt': endAt?.millisecondsSinceEpoch,
    };
  }

  factory EventSettingModel.fromMap(Map<String, dynamic> map) {
    return EventSettingModel(
      name: map['name'] as String,
      pickupNote: map['pickupNote'] as String,
      startAt: map['startAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startAt'] as int)
          : null,
      endAt: map['endAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endAt'] as int)
          : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory EventSettingModel.fromJson(String source) =>
      EventSettingModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
