import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static const String themeIsLightKey = 'themeIsDark';

  static final UserPreferencesService _singleton =
      UserPreferencesService._internal();

  factory UserPreferencesService() {
    return _singleton;
  }

  UserPreferencesService._internal();
  late SharedPreferences _prefs;

  Future initUserPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get themeIsDark => _prefs.getBool(themeIsLightKey) ?? false;
  set themeIsDark(bool t) => _prefs.setBool(themeIsLightKey, t);
}
