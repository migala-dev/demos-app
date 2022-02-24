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
