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

import 'dart:async';

import 'package:bloc/bloc.dart';

class ApiTimestamp {
  final DateTime timestamp = DateTime.now();
}

class ApiPendingCubit extends Cubit<bool> {
  static final ApiPendingCubit _apiPendingCubit = ApiPendingCubit._internal();
  final Duration intervalDuration = const Duration(seconds: 1);
  List<ApiTimestamp> timestampList = [];

  ApiPendingCubit._internal() : super(false) {
    Timer.periodic(intervalDuration, (timer) {
      checkTimestamps();
    });
  }

  factory ApiPendingCubit() {
    return _apiPendingCubit;
  }

  void addApiTimestamp(ApiTimestamp apiTimestamp) {
    timestampList.add(apiTimestamp);
  }

  void removeApiTimestamp(ApiTimestamp apiTimestamp) {
    timestampList.removeWhere((t) => t == apiTimestamp);
  }

  void checkTimestamps() {
    DateTime now = DateTime.now();
    if (timestampList
            .where((t) => now.difference(t.timestamp).inMilliseconds < 3000)
            .isEmpty &&
        state == true) {
      emit(false);
    } else if (timestampList
            .where((t) =>
                now.difference(t.timestamp).inMilliseconds > 500 &&
                now.difference(t.timestamp).inMilliseconds < 3000)
            .isNotEmpty &&
        state == false) {
      emit(true);
    }
  }
}
