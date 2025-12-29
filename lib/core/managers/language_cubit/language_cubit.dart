import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/services/shared_prefrence_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit({required this.prefs}) : super(const Locale('ar'));
  final SharedPreferences prefs;

  void changeLanguage(String languageCode) {
    prefs.setString(SharedPrefrenceDb.language, languageCode);

    emit(Locale(languageCode));
  }

  Locale getLocal() {
    Locale local =
        prefs.getString(SharedPrefrenceDb.language) == null
            ? Locale('en')
            : Locale(prefs.getString(SharedPrefrenceDb.language)!);
    return local;
  }
}
