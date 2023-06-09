import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

class Logger {
  Future<void> debug([dynamic message]) async {
    if (!kReleaseMode) {
      const color = '\x1B[33m';

      _log(message: message, color: color);
    }
  }

  Future<void> error(Object error, [StackTrace? stackTrace]) async {
    if (!kReleaseMode) {
      const color = '\x1B[31m';
      final message = "$error\n${stackTrace ?? ''}";

      _log(message: message, color: color);
    } else {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }

  void _log({required dynamic message, required String color}) {
    if (kIsWeb) {
      final messageArr = message.toString().split('\n');

      final stackTrace = stack_trace.Trace.current()
          .terse
          .frames
          .where((e) => e.toString().contains('online_bazaar'))
          .map((e) => '$color| $e')
          .join('\n');

      debugPrint(
        '$color────────────────────────────────────────────────────────────────────────────────────',
      );
      debugPrint('$color| ${DateTime.now()}');
      debugPrint('$color| ${messageArr[0]}');
      debugPrint(stackTrace);

      return;
    }

    final frame = stack_trace.Trace.current(2).terse.frames[0];

    log('$color────────────────────────────────────────────────────────────────────────────────────');
    log('$color| ${DateTime.now()}');
    log('$color| $frame');
    log('$color| $message');
  }
}
