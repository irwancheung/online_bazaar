// TODO: Uncomment kalau akan menggunakan remote config
// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:online_bazaar/exports.dart';
// import 'package:online_bazaar/features/shared/data/models/event_model.dart';
// import 'package:online_bazaar/features/shared/domain/entities/event.dart';

// part 'config_state.dart';

// class ConfigCubit extends HydratedCubit<ConfigState> {
//   final FirebaseRemoteConfig remoteConfig;

//   ConfigCubit({required this.remoteConfig})
//       : super(
//           ConfigState(
//             event: Event(
//               id: 'id',
//               title: '',
//               pickupNote: '',
//               startAt: DateTime.utc(0),
//               endAt: DateTime.utc(0),
//             ),
//           ),
//         );

//   Future<void> fetchConfig() async {
//     try {
//       await remoteConfig.fetchAndActivate();

//       final eventTitle = remoteConfig.getString('event_title');
//       final eventPickupNote = remoteConfig.getString('event_pickup_note');
//       final eventStartAt = remoteConfig.getInt('event_start_at');
//       final eventEndAt = remoteConfig.getInt('event_end_at');

//       emit(
//         ConfigState(
//           event: Event(
//             id: 'id',
//             title: eventTitle,
//             pickupNote: eventPickupNote,
//             startAt: DateTime.fromMillisecondsSinceEpoch(eventStartAt),
//             endAt: DateTime.fromMillisecondsSinceEpoch(eventEndAt),
//           ),
//         ),
//       );
//     } catch (e, s) {
//       logger.error(e, s);
//     }
//   }

//   @override
//   ConfigState? fromJson(Map<String, dynamic> json) {
//     return ConfigState.fromMap(json);
//   }

//   @override
//   Map<String, dynamic>? toJson(ConfigState state) {
//     return state.toMap();
//   }
// }
