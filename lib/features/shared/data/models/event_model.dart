import 'dart:convert';

import 'package:online_bazaar/features/shared/domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.title,
    required super.pickupNote,
    required super.startAt,
    required super.endAt,
  });

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      id: event.id,
      title: event.title,
      pickupNote: event.pickupNote,
      startAt: event.startAt,
      endAt: event.endAt,
    );
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? pickupNote,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      pickupNote: pickupNote ?? this.pickupNote,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'pickupNote': pickupNote,
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt.millisecondsSinceEpoch,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      pickupNote: map['pickupNote'] as String,
      startAt: DateTime.fromMillisecondsSinceEpoch(map['startAt'] as int),
      endAt: DateTime.fromMillisecondsSinceEpoch(map['endAt'] as int),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
