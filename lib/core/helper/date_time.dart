import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDateTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("MMMM d, yyyy hh:mm a").format(dateTime);
  }
}
