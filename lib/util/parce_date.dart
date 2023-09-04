import 'package:intl/intl.dart';

String parceDate(String date) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
}
