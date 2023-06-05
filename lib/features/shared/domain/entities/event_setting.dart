import 'package:equatable/equatable.dart';

class EventSetting extends Equatable {
  final String name;
  final String pickupNote;
  final DateTime? startAt;
  final DateTime? endAt;

  const EventSetting({
    required this.name,
    required this.pickupNote,
    this.startAt,
    this.endAt,
  });

  @override
  List<Object?> get props => [name, pickupNote, startAt, endAt];
}
