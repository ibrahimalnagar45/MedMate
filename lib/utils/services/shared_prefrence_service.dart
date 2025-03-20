import 'package:shared_preferences/shared_preferences.dart';

import '../service_locator.dart';

class SharedPrefrenceService {
  SharedPrefrenceService._();

  static final SharedPrefrenceService instance = SharedPrefrenceService._();
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
