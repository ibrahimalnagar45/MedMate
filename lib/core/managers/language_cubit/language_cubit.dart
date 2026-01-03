import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/services/shared_prefrence_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<Locale> {
  final SharedPreferences prefs;

  LanguageCubit._(this.prefs, Locale initialLocale) : super(initialLocale);

  /// Factory to create the cubit with the saved locale
  static LanguageCubit create(SharedPreferences prefs) {
    final savedLang = prefs.getString(SharedPrefrenceDb.language) ?? 'en';
    return LanguageCubit._(prefs, Locale(savedLang));
  }

  void changeLanguage(String languageCode) {
    prefs.setString(SharedPrefrenceDb.language, languageCode);
    emit(Locale(languageCode));
  }

  Locale getLocal() => state;
}

 