import 'package:shared_preferences/shared_preferences.dart';

class ModeManager {
  static const _modeKey = 'app_mode'; // or 'theme_mode'

  // Save mode
  static Future<void> setMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode);
  }

  // Get mode
  static Future<String?> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_modeKey);
  }
}
