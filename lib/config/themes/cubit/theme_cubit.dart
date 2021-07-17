import 'package:demos_app/config/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:demos_app/config/themes/light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool _isLigth = true;

  ThemeCubit() : super(ligthTheme);

  void changeTheme() {
    this._isLigth = !this._isLigth;

    if (this._isLigth) {
      emit(ligthTheme);
    } else {
      emit(darkTheme);
    }
  }
}
