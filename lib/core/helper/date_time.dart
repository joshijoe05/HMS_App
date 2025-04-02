import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatDateTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("MMMM d, yyyy hh:mm a").format(dateTime);
  }

  static String formatIsoTo24Time(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("HH:mm").format(dateTime);
  }

  static String formatDateToDayMonthYear(String dateStr) {
    DateTime date = DateTime.parse(dateStr);

    String day = DateFormat('d').format(date);
    String month = DateFormat('MMM').format(date);
    String year = DateFormat('y').format(date);

    String dayWithSuffix = _getDayWithSuffix(int.parse(day));
    return '$dayWithSuffix $month $year';
  }

  static String _getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }
}
