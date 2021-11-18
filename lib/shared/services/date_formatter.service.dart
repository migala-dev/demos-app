import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatterService {
  static String parseToStandardDate(String date) {
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      DateTime inputDate = dateFormat.parse(date);

      initializeDateFormatting('es');
      var outputFormat = DateFormat('dd/MMMM/yyyy', 'es');
      return outputFormat.format(inputDate);
    } catch (e) {
      return '';
    }
  }
}
