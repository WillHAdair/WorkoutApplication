String todaysDate()  {
  var date = DateTime.now();

  String year = date.year.toString();

  String month = date.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = date.day.toString();
    if (day.length == 1) {
    day = '0$day';
    }
    return year + month + day;
}

DateTime createDateTimeObject(String date) {
  int year = int.parse(date.substring(0, 4));
  int month = int.parse(date.substring(4, 6));
  int day = int.parse(date.substring(6, 8));

  return DateTime(year, month, day);
}

String convertDateTimeToString(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = date.day.toString();
    if (day.length == 1) {
    day = '0$day';
    }
    return year + month + day;  
}