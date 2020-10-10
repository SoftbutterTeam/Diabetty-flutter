import 'package:intl/intl.dart';

class DateMixin {
  bool isSameDay(DateTime x, DateTime y) {
    if (x.day != y.day || x.month != y.month || x.year != y.year) {
      return false;
    }
    return true;
  }

  String shortenDateRepresent(DateTime dateTime) {
    String dayOfWeek;
    if (isSameDay(dateTime, DateTime.now()))
      dayOfWeek = "Today, ";
    else if (isSameDay(dateTime, DateTime.now().add(Duration(days: 1))))
      dayOfWeek = "Tommorow, ";
    else if (isSameDay(dateTime, DateTime.now().subtract(Duration(days: 1))))
      dayOfWeek = "Yesterday, ";
    else
      dayOfWeek = DateFormat("EEEE, ").format(dateTime);
    return dayOfWeek + DateFormat("d MMM").format(dateTime);
  }

  String getDayOfMonthSuffix(final int n) {
    if (n >= 11 && n <= 13) {
      return '\u1d57\u02b0';
    }
    switch (n % 10) {
      case 1:
        return '\u02e2\u1d57';
      case 2:
        return '\u207f\u1d48';
      case 3:
        return '\u02b3\u1d48';
      default:
        return '\u1d57\u02b0';
    }
  }
}
