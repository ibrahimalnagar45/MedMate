import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/mode_manager.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  ModeCubit() : super(ModeInitial());

  Future<ThemeMode> getMode() async {
    String mode = await ModeManager.getMode() ?? 'light';

    emit(Modechanged(mode: mode));
    return mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleMode() async {
    final String newMode;
    try {
      newMode = await ModeManager.getMode() == 'light' ? 'dark' : 'light';
      await ModeManager.setMode(newMode);
      log(newMode);
    } catch (e) {
      throw Exception(e.toString());
    }
    emit(Modechanged(mode: newMode));
  }
}
