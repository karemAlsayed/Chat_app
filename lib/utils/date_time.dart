import 'package:intl/intl.dart';

class MyDateTime {
  static DateTime dateFormat(String time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateTime(
      dt.year,
      dt.month,
      dt.day,
    );
  }

  static String timeDate(String time) {
    String t = '';
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    t = DateFormat('jm').format(dt).toString();
    return t;
  }

  static String dateAndTime(String time) {
    String dat = '';
     final today = DateTime.now();
     final yesterday = today.subtract(const Duration(days: 1));
     final t = DateTime(today.year, today.month, today.day);
     final y = DateTime(yesterday.year, yesterday.month, yesterday.day);

    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final d = DateTime(dt.year, dt.month, dt.day);
    if (d == t) {
      dat = 'Today';
    } else if (d == y) {  
      dat = 'Yesterday';
    } else if (dt.year == today.year) {
      dat = DateFormat.MMMd().format(dt).toString();
    }
    else {
      dat = DateFormat.yMMMd().format(dt).toString();
    }

    return dat;
  }
}
