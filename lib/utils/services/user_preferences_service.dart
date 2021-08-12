import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static final String themeIsLightKey = 'themeIsLight';

  static final UserPreferencesService _singleton =
      UserPreferencesService._internal();

  factory UserPreferencesService() {
    return _singleton;
  }

  UserPreferencesService._internal();
  late SharedPreferences _prefs;

  Future initUserPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  bool get themeIsLight => this._prefs.getBool(themeIsLightKey) ?? true;
  set themeIsLight(bool t) => this._prefs.setBool(themeIsLightKey, t);
}
