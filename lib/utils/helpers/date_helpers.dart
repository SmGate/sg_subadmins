

import 'package:intl/intl.dart';

class DateHelpers {
  String formatDate(String dateString) {
    try {
      // Parse the input date string
      DateTime date = DateTime.parse(dateString);

      // Format the date into 'yyyy-MM-dd' format
      String formattedDate = DateFormat('yyyy-MM-dd').format(date.toLocal());

      return formattedDate;
    } catch (e) {
      // Handle any parsing errors
      return 'Invalid date format';
    }
  }
}

String formatTime(String time) {
  if (time == "NA") {
    return "NA";
  }

  final inputFormat = DateFormat("HH:mm:ss");
  final outputFormat = DateFormat("h:mm a");

  try {
    final parsedTime = inputFormat.parse(time, true).toLocal();
    return outputFormat.format(parsedTime);
  } catch (e) {
    return "";
  }
}
