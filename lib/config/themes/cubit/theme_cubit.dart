import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:demos_app/utils/services/user_preferences_service.dart';
import 'package:demos_app/config/themes/dark_theme.dart';
import 'package:demos_app/config/themes/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final _userPrefs = UserPreferencesService();
  bool _isLigth;

  ThemeCubit(bool isLigth)
      : this._isLigth = isLigth,
        super(isLigth ? ligthTheme : darkTheme);

  void changeTheme() {
    this._isLigth = !this._isLigth;
    this._userPrefs.themeIsLight = this._isLigth;

    if (this._isLigth) {
      emit(ligthTheme);
    } else {
      emit(darkTheme);
    }
  }
}
