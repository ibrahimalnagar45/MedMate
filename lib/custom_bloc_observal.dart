import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserval implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('$bloc $change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('close $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('created $bloc ');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('error : $error for the $bloc ');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }
}
