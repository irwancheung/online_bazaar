import 'package:bloc/bloc.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // logger.debug('onCreate: $bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // logger.debug('onEvent: $bloc\n$event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.error('onError: $bloc\n$error\n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // logger.debug('onChange: $bloc\n$change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // logger.debug('onTransition: $bloc\n$transition');
  }
}
