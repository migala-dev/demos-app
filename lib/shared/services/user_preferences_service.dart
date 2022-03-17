/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
