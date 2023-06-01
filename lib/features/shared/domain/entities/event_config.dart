import 'package:equatable/equatable.dart';

class EventConfig extends Equatable {
  final String name;
  final String pickupNote;
  final DateTime? startAt;
  final DateTime? endAt;

  const EventConfig({
    required this.name,
    required this.pickupNote,
    this.startAt,
    this.endAt,
  });

  @override
  List<Object?> get props => [name, pickupNote, startAt, endAt];
}
