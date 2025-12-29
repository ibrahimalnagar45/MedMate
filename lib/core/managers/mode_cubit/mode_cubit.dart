import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/mode_manager.dart';
import '../../themes/app_theme.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ThemeData> {
  ModeCubit() : super(AppTheme.buildLightTheme());

  Future<void> getMode() async {
    ThemeData mode = await ModeManager.getMode();

    emit(mode);
  }

  void toggleMode() async {
    final String newMode;
    try {
      ThemeData newMode = await ModeManager.getMode();
      await ModeManager.setMode(newMode);
      
      emit(newMode);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
