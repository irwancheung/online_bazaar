import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/event_config.dart';

class EventConfigModel extends EventConfig {
  const EventConfigModel({
    required super.name,
    required super.pickupNote,
    super.startAt,
    super.endAt,
  });

  factory EventConfigModel.fromEntity(EventConfig eventConfig) {
    return EventConfigModel(
      name: eventConfig.name,
      pickupNote: eventConfig.pickupNote,
      startAt: eventConfig.startAt,
      endAt: eventConfig.endAt,
    );
  }

  EventConfig copyWith({
    String? name,
    String? pickupNote,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return EventConfig(
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

  factory EventConfigModel.fromMap(Map<String, dynamic> map) {
    return EventConfigModel(
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

  factory EventConfigModel.fromJson(String source) =>
      EventConfigModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
