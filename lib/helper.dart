class Helper {
  static String getMonthFormatted(DateTime dateTime) {
    if (dateTime.month < 10) {
      return '0${dateTime.month}';
    } else {
      return dateTime.month.toString();
    }
  }

  static DateTime parseDate(String date) {
    List<String> dateInfo = date.split(RegExp(r'\.'));

    if (dateInfo.length != 3) {
      throw const FormatException();
    }

    int day = int.parse(dateInfo[0]);
    int month = int.parse(dateInfo[1]);
    int year = int.parse(dateInfo[2]);

    return DateTime(year, month, day);
  }
  
  static DateTime parseDateFromDB(String date) {
    List<String> dateInfo = date.split(RegExp(r'-'));

    int year = int.parse(dateInfo[0]);
    int month = int.parse(dateInfo[1]);
    int day = int.parse(dateInfo[2]);

    return DateTime(year, month, day);
  }

  static String formatDate(DateTime date) {
    return '${date.day}.${getMonthFormatted(date)}.${date.year}';
  }
}
