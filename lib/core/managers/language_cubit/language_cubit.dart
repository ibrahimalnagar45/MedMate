import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/services/shared_prefrence_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({required this.prefs}) : super(LanguageInitial());
  final SharedPreferences prefs;
  void changeLanguage(String languageCode) {
    try {
      prefs.setString(SharedPrefrenceDb.language, languageCode);

      emit(LanguageChanged(languageCode: languageCode));
    } on Exception catch (e) {
      emit(LanguageChangeFailure(erMessage: e.toString()));
    }
  }

  String getLocal() {
    String local =
        prefs.getString(SharedPrefrenceDb.language) == null
            ? 'en'
            : prefs.getString(SharedPrefrenceDb.language)!;
    return local;
  }
}
