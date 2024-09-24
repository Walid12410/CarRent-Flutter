import 'package:intl/intl.dart';

String getCurrentTimeInISO() {
  DateTime now = DateTime.now().toUtc();
  DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");
  return formatter.format(now);
}