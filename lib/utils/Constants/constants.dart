// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

final Color primaryColor = AppColors.appThem;
const String assetsBaseUrl = "assets/";

Future<String> getDate(BuildContext context) async {
  DateTime date = new DateTime(2022, 12, 24);
  String? myDate;

  DateTime? newDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor, // <-- SEE HERE
              // <-- SEE HERE
              // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  if (newDate == null) {
    return "";
  }

  date = newDate;
  print(date);

  date.month;
  date.year;
  date.day;
  myDate = date.day.toString() +
      "/" +
      date.month.toString() +
      "/" +
      date.year.toString();

  return myDate;
}

/* Validations */

String? emptyStringValidator(String? val) {
  String string = val!.trim();

  if (string.isEmpty) {
    return "This field is required";
  } else {
    return null;
  }
}

//  ID CARD VALIDATOR
// String? validateExpression(String? value) {
//   // Regular expression pattern to match the given expression format
//   RegExp regex = RegExp(r'^\d{5}-\d{7}-\d$');
//   if (value!.isEmpty) {
//     return 'Expression field cannot be empty.';
//   } else if (!regex.hasMatch(value)) {
//     return 'Invalid cnic  hint "37405-7384570-1"';
//   }
//   return null;
// }

String? validateExpression(String? value) {
  if (value == null || value.isEmpty) {
    return 'Expression field cannot be empty.';
  } else if (value.length > 15) {
    return 'Invalid cnic  hint "37405-7384570-1';
  }
  return null;
}

String? passwordValidator(String? v) {
  RegExp smallAlphabets = RegExp("(?=.*?[a-z])");
  RegExp capitalAlphabets = RegExp("(?=.*?[A-Z])");
  RegExp specialCharacter = RegExp("(?=.*?[#?!@\$%^&*-])");
  String string = v!.trim();
  if (string.isEmpty) {
    return 'Please enter the password';
  } else if (string.length < 6 || string.length > 25) {
    return 'Password length should be in between 6 and 25';
  } else if (!smallAlphabets.hasMatch(string)) {
    return 'Password must includes at least one lower case English letter. ';
  } else if (!capitalAlphabets.hasMatch(string)) {
    return 'Password must includes at least one upper case English letter.';
  } else if (!specialCharacter.hasMatch(string)) {
    return 'Password must includes at least one special character.';
  } else {
    return null;
  }
}

String? emailValidator(String? v) {
  String string = v!.trim();
  bool _emailValid = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(string);

  if (string.isEmpty) {
    return 'Please enter your email';
  } else if (!_emailValid) {
    return 'Please enter a valid email';
  } else {
    return null;
  }
}

String? cnicValidator(String? v) {
  String string = v!.trim();
  bool _cnicValid = RegExp("^[0-9]{5}-[0-9]{7}-[0-9]\$").hasMatch(string);

  if (string.isEmpty) {
    return 'Please enter your CNIC';
  } else if (!_cnicValid) {
    return 'Please enter a valid CNIC  XXXXX-XXXXXXX-X  ';
  } else {
    return null;
  }
}

String laravelDateToFormattedDate(String laravelDate) {
  DateTime date = DateTime.parse(laravelDate).toLocal();

  String formattedDate = DateFormat('d MMM y').format(date);

  return formattedDate;
}

String convertLaravelDateFormatToDayMonthYearDateFormat(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate).toLocal();
  String formattedDate = DateFormat('d MMM y').format(dateTime);
  return formattedDate;
}

String convertDateFormatToDayMonthYearDateFormat(String inputDate) {
  DateTime parsedDate = DateTime.parse(inputDate).toLocal();
  String formattedDate = DateFormat("MMM, d, yyyy").format(parsedDate);
  return formattedDate;
}

String convertUtcToFormattedTime(String utcTimestamp) {
  DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String convertUtcToFormattedTimeAdd5Hours(String utcTimestamp) {
  DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();

  // Add 5 hours to the DateTime
  dateTime = dateTime.add(Duration(hours: 5));

  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String convertUtcToDayOfWeekWithOffset(String utcTimestamp) {
  DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();

  // Add 5 hours to the DateTime
  dateTime = dateTime.add(Duration(hours: 5));

  // Get the day of the week abbreviation (e.g., "Sun")
  String dayOfWeek = DateFormat.E().format(dateTime);
  return dayOfWeek;
}

enum Status { completed, loading, error }

Future<bool?> myToast(
    {required msg,
    Color? backgroundColor,
    bool isNegative = false,
    ToastGravity? gravity}) async {
  bool? toast = await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: isNegative ? Colors.red : Colors.black,
      textColor: Colors.white,
      fontSize: 16.0.sp);
  return toast;
}

String formatTimeToAMPM(String time) {
// Parse the input time string to create a DateTime object
  DateTime parsedTime = DateFormat('HH:mm').parse(time, true).toLocal();

// Format the DateTime object to include AM/PM
  String formattedTime = DateFormat('h:mm a').format(parsedTime);

  return formattedTime;
}

String Hour12formatTime(String inputTime) {
  try {
    // Parse the input time string
    DateTime dateTime = DateFormat("HH:mm:ss").parse(inputTime);

    // Format the time in 12-hour format with AM/PM
    String formattedTime = DateFormat("h:mm a").format(dateTime);

    return formattedTime;
  } catch (e) {
    // Handle parsing errors, e.g., invalid time format
    return "N/A";
  }
}
