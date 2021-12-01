import 'package:demos_app/shared/services/user_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:demos_app/config/themes/dark_theme.dart';
import 'package:demos_app/config/themes/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final _userPrefs = UserPreferencesService();
  bool isDark;

  ThemeCubit(this.isDark) : super(isDark ? darkTheme : ligthTheme);

  void toggleTheme() {
    isDark = !isDark;
    _userPrefs.themeIsDark = isDark;
    final ThemeData theme = isDark ? darkTheme : ligthTheme;
    emit(theme);
  }
}
