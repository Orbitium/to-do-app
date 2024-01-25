class DateFormat {
  static String convertToCustomFormat(DateTime dateTime) {
    // Get day name
    String dayName = getDayName(dateTime.weekday);

    // Get current day index
    int dayIndex = dateTime.day;

    // Get month name
    String monthName = getMonthName(dateTime.month);

    // Get year
    int year = dateTime.year;

    // Get clock time
    String clockTime = getClockTime(dateTime);

    // Concatenate the components
    String formattedDateTime =
        '${dayName.substring(0, 3)}, $dayIndex ${monthName.substring(0, 3)} $year $clockTime';

    return formattedDateTime;
  }

  static String getDayName(int weekday) {
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return days[weekday - 1];
  }

  static String getMonthName(int month) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return months[month - 1];
  }

  static String getClockTime(DateTime dateTime) {
    // Determine whether it's AM or PM
    String period = (dateTime.hour < 12) ? 'AM' : 'PM';

    // Adjust hours to 12-hour format
    int hours = (dateTime.hour > 12) ? dateTime.hour - 12 : dateTime.hour;

    // Format the time as HH:mm:ss AM/PM
    String formattedTime = '$hours:${dateTime.minute} $period';

    return formattedTime;
  }
}
