import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:demos_app/utils/services/user_preferences_service.dart';
import 'package:demos_app/config/themes/dark_theme.dart';
import 'package:demos_app/config/themes/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final _userPrefs = UserPreferencesService();
  bool isDark;

  ThemeCubit(this.isDark) : super(isDark ? darkTheme : ligthTheme);

  void changeTheme() {
    this.isDark = !this.isDark;
    this._userPrefs.themeIsDark = this.isDark;

    if (this.isDark) {
      emit(darkTheme);
    } else {
      emit(ligthTheme);
    }
  }
}
