import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String pickupNote;
  final DateTime startAt;
  final DateTime endAt;

  const Event({
    required this.id,
    required this.title,
    required this.pickupNote,
    required this.startAt,
    required this.endAt,
  });

  @override
  List<Object?> get props => [id, title, pickupNote, startAt, endAt];
}
