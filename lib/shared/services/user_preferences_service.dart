import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static final String themeIsLightKey = 'themeIsDark';

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

  bool get themeIsDark => this._prefs.getBool(themeIsLightKey) ?? false;
  set themeIsDark(bool t) => this._prefs.setBool(themeIsLightKey, t);
}
