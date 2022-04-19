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

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatterService {
  static String parseToStandardDate(String date) {
    try {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      final DateTime inputDate = dateFormat.parse(date);

      initializeDateFormatting('es');
      final outputFormat = DateFormat('dd/MMMM/yyyy', 'es');
      return outputFormat.format(inputDate);
    } catch (e) {
      return date;
    }
  }


  static String parseDateToStandardDateFormat(DateTime date) {
      initializeDateFormatting('es');
      final outputFormat = DateFormat('dd/MMMM/yyyy', 'es');
      return outputFormat.format(date);
  }

  static String parseToDayMonthYearDate(String date) {
    try {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      final DateTime inputDate = dateFormat.parse(date);

      final outputFormat = DateFormat('dd/MM/yyyy');
      return outputFormat.format(inputDate);
    } catch (e) {
      return date;
    }
  }

  static String parseToDayMonthYearHourDate(String date) {
    try {
      final dateFormat = DateFormat('yyyy-MM-ddThh:mm');
      final inputDate = dateFormat.parse(date);

      final outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
      return outputFormat.format(inputDate);
    } catch (e) {
      return date;
    }
  }

}
