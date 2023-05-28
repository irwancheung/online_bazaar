part of 'config_cubit.dart';

class ConfigState extends Equatable {
  final Event event;

  const ConfigState({required this.event});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': EventModel.fromEntity(event).toMap(),
    };
  }

  factory ConfigState.fromMap(Map<String, dynamic> map) {
    return ConfigState(
      event: EventModel.fromMap(map['event'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [event];
}
