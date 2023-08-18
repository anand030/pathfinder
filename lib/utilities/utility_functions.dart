import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool> isInternetConnected() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    debugPrint('Internet connection');
  } else {
    debugPrint('No internet');
  }
  return result;
}

Future<dynamic> appVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

bool isValidEmail(String email) {
  bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

// String formatDate(String dateFormat) {
//   return DateFormat('h:mm a  dd/MM/yy').format(DateTime.parse(dateFormat));
// }
