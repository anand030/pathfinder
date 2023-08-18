import 'package:pathfinder/utilities/consts/pref_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  Future<void> clearSPData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  // setUserLoggedIn() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(PrefConsts.isLoggedIn, true);
  // }
  //
  // Future<bool?> getUserLoggedIn() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(PrefConsts.isLoggedIn);
  // }

  setUserAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConsts.authToken, value);
  }

  Future<String?> getUserAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConsts.authToken);
  }

  setPerformanceData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConsts.performanceData, value);
  }

  Future<String?> getPerformanceData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConsts.performanceData);
  }

  setAMPerformanceData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConsts.areaManagerPerformanceData, value);
  }

  Future<String?> getAMPerformanceData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConsts.areaManagerPerformanceData);
  }

  setNotificationData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConsts.notificationData, value);
  }

  Future<String?> getNotificationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConsts.notificationData);
  }

  setUserData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefConsts.userData, value);
  }

  Future<String?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefConsts.userData);
  }
}
