import 'package:pathfinder/utilities/pref_utils.dart';

import 'api_base_helper.dart';

class Repository {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final _loginEndPoint = 'auth/login';
  final _sendOTPEndPoint = 'api/OTP?EmailID=';
  final _resetPasswordEndPoint = 'api/ResetPassword';
  final _userPerformanceEndPoint = 'api/UserPerformance';
  final _hospitalDetailsEndPoint = 'api/Hospital?HospitalID=';
  final _notesEndPoint = 'api/UserNote/AllNotes?HospitalID=';

  // final _addNoteEndPoint = 'api/UserNote/AddNotes';
  final _addNoteEndPoint = 'api/Indicators';
  final _notificationListEndPoint = 'api/UserNotification';
  final _areaManagePerformanceEndPoint = 'api/AMPerformance';
  final _mRPerformanceEndPoint = 'api/AMPerformance/MRPerformance?UserId=';
  final _setSecurityPinEndPoint = 'api/userPin?Pin=';
  final _authenticateSecurityPinEndPoint = 'api/userPin/Authenticate?UserPin=';

  Future<Object> login(Map body) async {
    final response = await apiBaseHelper.post(
        endpoint: _loginEndPoint,
        body: body,
        headers: {'content-type': 'application/json'});
    return response;
  }

  Future<Object> sendOTP(String email) async {
    final response = await apiBaseHelper.get(
        endpoint: '$_sendOTPEndPoint$email',
        headers: {'content-type': 'application/json'});
    return response;
  }

  Future<Object> resetPassword(Map body) async {
    final response = await apiBaseHelper.post(
        endpoint: _resetPasswordEndPoint,
        body: body,
        headers: {'content-type': 'application/json'});
    return response;
  }

  Future<Object> getUserPerformance() async {
    final response = await apiBaseHelper.get(
        endpoint: _userPerformanceEndPoint, headers: await getHeader());
    return response;
  }

  Future<Object> getHospitalDetails(int hospitalId) async {
    final response = await apiBaseHelper.get(
        endpoint: '$_hospitalDetailsEndPoint$hospitalId',
        headers: await getHeader());
    return response;
  }

  Future<Object> getAllNotes(int hospitalId) async {
    final response = await apiBaseHelper.get(
        endpoint: '$_notesEndPoint$hospitalId', headers: await getHeader());
    return response;
  }

  Future<Object> getAMPerformance() async {
    final response = await apiBaseHelper.get(
        endpoint: _areaManagePerformanceEndPoint, headers: await getHeader());
    return response;
  }

  Future<Object> getMRPerformance(int userID) async {
    final response = await apiBaseHelper.get(
        endpoint: '$_mRPerformanceEndPoint$userID', headers: await getHeader());
    return response;
  }

  Future<Object> getAllNotification() async {
    final response = await apiBaseHelper.get(
        endpoint: '$_notificationListEndPoint', headers: await getHeader());
    return response;
  }

  Future<Object> addNote(Map body) async {
    final response = await apiBaseHelper.post(
        endpoint: _addNoteEndPoint, body: body, headers: await getHeader());
    return response;
  }

  Future<Object> setSecurityPin(String pin) async {
    final response = await apiBaseHelper.post(
        endpoint: '$_setSecurityPinEndPoint$pin',
        body: {},
        headers: await getHeader());
    return response;
  }

  Future<Object> authenticateSecurityPin(String pin) async {
    final response = await apiBaseHelper.get(
        endpoint: '$_authenticateSecurityPinEndPoint$pin',
        headers: await getHeader());
    return response;
  }

  //get header
  Future<Map<String, String>> getHeader() async {
    var authToken = await PrefUtils().getUserAuthToken();
    return {
      'content-type': 'application/json',
      'Authorization': 'Bearer $authToken'
    };
  }
}
