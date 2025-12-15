import 'package:clone_whatsapp_round34/src/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDataSource {
  final SharedPreferences _prefs;

  LanguageDataSource(this._prefs);

  String getLanguage() {
    return _prefs.getString(PreferencesKey.appLanguage) ?? 'en';
  }

  Future<void> setLanguage(String lang) async {
    await _prefs.setString(PreferencesKey.appLanguage, lang);
  }
}