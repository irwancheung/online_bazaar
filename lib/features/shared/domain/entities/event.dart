import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String pickupNote;
  final DateTime startAt;
  final DateTime endAt;

  const Event({
    required this.name,
    required this.pickupNote,
    required this.startAt,
    required this.endAt,
  });

  @override
  List<Object?> get props => [name, pickupNote, startAt, endAt];
}
