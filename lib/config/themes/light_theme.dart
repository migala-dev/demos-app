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

import 'package:flutter/material.dart';

// TODO: define color palette and fonts
final ligthTheme = ThemeData.light().copyWith(
    tabBarTheme:
        ThemeData.light().tabBarTheme.copyWith(labelColor: Colors.black),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.3,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
        textTheme: const TextTheme(
            caption: TextStyle(color: Colors.black, fontSize: 20.0),
            headline6: TextStyle(color: Colors.black, fontSize: 20.0))));
