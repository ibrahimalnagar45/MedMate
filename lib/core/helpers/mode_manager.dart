import 'package:flutter/material.dart';
import 'package:midmate/core/themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../managers/mode_cubit/mode_cubit.dart';

class ModeManager {
  static const _modeKey = 'app_mode';

  /// Save mode as a simple string
  static Future<void> setMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode.name); // "light" or "dark"
  }

  /// Get mode; default to light if nothing saved
  static Future<AppThemeMode> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    final modeString = prefs.getString(_modeKey) ?? 'light';
    return modeString == 'dark' ? AppThemeMode.dark : AppThemeMode.light;
  }

  /// Optional: helper to convert to ThemeMode
  static ThemeMode toThemeMode(AppThemeMode mode) {
    return mode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
  }
}

// class ModeManager {
//   static const _modeKey = 'app_mode'; // or 'theme_mode'

//   // Save mode
//   static Future<void> setMode(ThemeData mode) async {
//     final prefs = await SharedPreferences.getInstance();
//     String te = mode == ThemeData.dark() ? 'dark' : 'light';
//     await prefs.setString(_modeKey, te);
//   }

//   // Get mode
//   static Future<ThemeData> getMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     final ThemeData theme =
//         prefs.getString(_modeKey) == 'light'
//             ? AppTheme.buildLightTheme()
//             : AppTheme.buildDarkTheme();
//     return theme;
//   }
// }
