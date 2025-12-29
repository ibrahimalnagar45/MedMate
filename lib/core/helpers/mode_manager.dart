import 'package:flutter/material.dart';
import 'package:midmate/core/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeManager {
  static const _modeKey = 'app_mode'; // or 'theme_mode'

  // Save mode
  static Future<void> setMode(ThemeData mode) async {
    final prefs = await SharedPreferences.getInstance();
    String te = mode == ThemeData.dark() ? 'dark' : 'light';
    await prefs.setString(_modeKey, te);
  }

  // Get mode
  static Future<ThemeData> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    final ThemeData theme =
        prefs.getString(_modeKey) == 'light'
            ? AppTheme.buildLightTheme()
            : AppTheme.buildDarkTheme();
    return theme;
  }
}
