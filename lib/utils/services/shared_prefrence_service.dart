import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceService {
  SharedPrefrenceService._();

  static final SharedPrefrenceService instance = SharedPrefrenceService._();
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

class SharedPrefrenceDb {
  static const String onBoardingVisited = 'onBoardingVisited';
  static const String username = 'User';
  static const String userId = 'userId';
  static const String userAge = 'userAge';
  static const String users = 'users';

  static const String ringtoneUri = 'ringtoneUri';
}
