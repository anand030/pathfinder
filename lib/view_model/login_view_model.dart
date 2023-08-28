import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:pathfinder/model/user_model.dart';
import 'package:pathfinder/network/api_status.dart';
import 'package:pathfinder/network/repository.dart';
import 'package:pathfinder/utilities/pref_utils.dart';

class LoginViewModel with ChangeNotifier {
  bool _loading = false;
  bool _showSnackBar = false;
  bool _showSnackBarOTP = false;

  // bool isUsedLoggedIn = false;
  final formKey = GlobalKey<FormState>();
  final formKeyPassword = GlobalKey<FormState>();
  final formKeySecurityPin = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _hidePasswordConfirm = true;
  UserModel userModel = UserModel();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPass = TextEditingController();
  TextEditingController textEditingControllerSecurityPin =
      TextEditingController();

  // String email = '';
  // String password = '';
  String newPassword = '';
  String otp = '';

  // String securityPin = '';

  bool get loading => _loading;

  bool get showSnackBar => _showSnackBar;

  bool get showSnackBarOTP => _showSnackBarOTP;

  bool get hidePassword => _hidePassword;

  bool get hidePasswordConfirm => _hidePasswordConfirm;

  Future<String?> userData() async {
    var userData = await PrefUtils().getUserData();
    return userData;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  setShowSnackBar(bool value) {
    _showSnackBar = value;
    notifyListeners();
  }

  setShowSnackBarOTP(bool value) {
    _showSnackBarOTP = value;
    notifyListeners();
  }

  setHidePasswordConfirm() {
    _hidePasswordConfirm = !_hidePasswordConfirm;
    notifyListeners();
  }

  login(
      {required void Function() onSuccess,
      required void Function(String?) onFailure}) async {
    setLoading(true);
    var body = {
      "username": textEditingControllerEmail.text.trim(),
      "password": textEditingControllerPass.text.trim(),
      "Otp": "0"
    };
    var response = await Repository().login(body);
    setLoading(false);
    if (response is Success) {
      textEditingControllerEmail.clear();
      textEditingControllerPass.clear();
      userModel = UserModel.fromJson(jsonDecode(response.response));
      onSuccess();
      PrefUtils().setUserData(response.response);
      PrefUtils().setUserAuthToken(userModel.token!);

      var token = await FirebaseMessaging.instance.getToken();
      await Repository().addFCMToken(token!);
    }
    if (response is Failure) {
      onFailure(response.errorResponse);
    }
  }

  sendOTP(
      {required void Function() onSuccess,
      required void Function(String?) onFailure}) async {
    var response = await Repository().sendOTP(textEditingControllerEmail.text);
    if (response is Success) {
      onSuccess();
      debugPrint('response ${response.response}');
    }
    if (response is Failure) {
      onFailure('Error');
      debugPrint('error response ${response.errorResponse}');
    }
  }

  setSecurityPin(
      {required void Function() onSuccess,
      required void Function(String?) onFailure}) async {
    setLoading(true);
    var response = await Repository()
        .setSecurityPin(textEditingControllerSecurityPin.text);
    setLoading(false);
    if (response is Success) {
      textEditingControllerSecurityPin.clear();
      onSuccess();
      debugPrint('response ${response.response}');
    }
    if (response is Failure) {
      onFailure('Error');
      debugPrint('error response ${response.errorResponse}');
    }
  }

  authenticateSecurityPin(
      {required void Function() onSuccess,
      required void Function(String?) onFailure}) async {
    setLoading(true);
    var response = await Repository()
        .authenticateSecurityPin(textEditingControllerSecurityPin.text);
    setLoading(false);
    if (response is Success) {
      textEditingControllerSecurityPin.clear();
      onSuccess();
    }
    if (response is Failure) {
      onFailure('Error');
    }
  }

  resetPassword(
      {required void Function() onSuccess,
      required void Function(String?) onFailure}) async {
    setLoading(true);
    var body = {
      "EmailID": textEditingControllerEmail.text,
      "Password": newPassword,
      "Otp": otp
    };

    var response = await Repository().resetPassword(body);
    setLoading(false);
    if (response is Success) {
      onSuccess();
      debugPrint('response ${response.response}');
    }
    if (response is Failure) {
      onFailure('Error');
      debugPrint('error response ${response.errorResponse}');
    }
  }
}
