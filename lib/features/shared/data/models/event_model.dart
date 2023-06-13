import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/event.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';

class EventModel extends Event {
  const EventModel({
    required super.name,
    required super.pickupNote,
    required super.startAt,
    required super.endAt,
  });

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      name: event.name,
      pickupNote: event.pickupNote,
      startAt: event.startAt,
      endAt: event.endAt,
    );
  }

  factory EventModel.fromEventSetting(EventSetting event) {
    return EventModel(
      name: event.name,
      pickupNote: event.pickupNote,
      startAt: event.startAt!,
      endAt: event.endAt!,
    );
  }

  EventModel copyWith({
    String? id,
    String? name,
    String? pickupNote,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return EventModel(
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
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt.millisecondsSinceEpoch,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      name: map['name'] as String,
      pickupNote: map['pickupNote'] as String,
      startAt: DateTime.fromMillisecondsSinceEpoch(map['startAt'] as int),
      endAt: DateTime.fromMillisecondsSinceEpoch(map['endAt'] as int),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
