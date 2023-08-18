import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:pathfinder/model/am_performance_model.dart';
import 'package:pathfinder/model/hospital_details_model.dart';
import 'package:pathfinder/model/mr_performance_model.dart';
import 'package:pathfinder/model/notes_list_model.dart';
import 'package:pathfinder/model/notes_model.dart';
import 'package:pathfinder/model/notifcation_model.dart';
import 'package:pathfinder/model/performance_model.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/utilities/pref_utils.dart';

import '../network/api_status.dart';
import '../network/repository.dart';

class DashboardViewModel with ChangeNotifier {
  bool _loading = true;
  bool _loadingHospital = false;
  bool _loadingNotes = false;
  bool _loadingNotification = false;
  final formKey = GlobalKey<FormState>();
  PerformanceModel performanceModel = PerformanceModel();
  AMPerformanceModel amPerformanceModel = AMPerformanceModel();
  HospitalDetailsModel hospitalDetailsModel = HospitalDetailsModel();
  NotificationModel notificationModel = NotificationModel();
  NotesModel notesModel = NotesModel();
  Hospitals selectedHospital = Hospitals();
  MRData selectedMR = MRData();
  List<MRData> mrList = [];
  List<Hospitals> hospitalList = [];
  String hospitalAlertType = '';
  NotesListModel selectedNotesListModel = NotesListModel();
  TextEditingController textEditingControllerNotes = TextEditingController();
  List<NotesListModel> noteList = [
    NotesListModel(text: 'Some text1', isSelected: false),
    NotesListModel(text: 'Some text2', isSelected: false),
    NotesListModel(text: 'Some text3', isSelected: false),
    NotesListModel(text: 'Some text4', isSelected: false),
    NotesListModel(text: 'Some text5', isSelected: false),
    NotesListModel(text: 'Some text6', isSelected: false),
  ];

  bool get loading => _loading;

  bool get loadingHospital => _loadingHospital;

  bool get loadingNotes => _loadingNotes;

  bool get loadingNotification => _loadingNotification;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setLoadingHospital(bool value) {
    _loadingHospital = value;
    notifyListeners();
  }

  setLoadingNotes(bool value) {
    _loadingNotes = value;
    notifyListeners();
  }

  setLoadingNotification(bool value) {
    _loadingNotification = value;
    notifyListeners();
  }

  // setHospitalAlertType(String value) {
  //   hospitalAlertType = value;
  //   notifyListeners();
  // }

  setNoteSelected(int index) {
    selectedNotesListModel = noteList[index];
    for (int i = 0; i < noteList.length; i++) {
      if (i == index) {
        noteList[i].isSelected = true;
      } else {
        noteList[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  getUserPerformance({required void Function(dynamic) onFailure}) async {
    var response = await Repository().getUserPerformance();
    if (response is Success) {
      await PrefUtils().setPerformanceData(response.response);
      getUserPerformanceFromLocalStorage();
    }
    debugPrint('errorRes ${response}');
    if (response is Failure) {
      debugPrint('errorRes ${response}');
      onFailure(response);
    }
  }

  getMRPerformance({required void Function(dynamic) onFailure}) async {
    // setLoading(true);
    var response = await Repository().getMRPerformance(selectedMR.id!);
    setLoading(false);
    if (response is Success) {
      performanceModel =
          PerformanceModel.fromJson(jsonDecode(response.response));
      hospitalList = performanceModel.data!.hospitals!;
      // await PrefUtils().setPerformanceData(response.response);
      // getUserPerformanceFromLocalStorage();
    }
    if (response is Failure) {
      onFailure(response);
    }
  }

  getUserPerformanceFromLocalStorage() async {
    var performanceData = await PrefUtils().getPerformanceData();
    if (performanceData!.isNotEmpty) {
      performanceModel = PerformanceModel.fromJson(jsonDecode(performanceData));
      hospitalList = performanceModel.data!.hospitals!;
    }
    setLoading(false);
  }

  getAMUserPerformance() async {
    var response = await Repository().getAMPerformance();
    if (response is Success) {
      await PrefUtils().setAMPerformanceData(response.response);
      getAMUserPerformanceFromLocalStorage();
    }
    if (response is Failure) {
      debugPrint('Error response ${response.errorResponse}');
      // onFailure('Error');
    }
  }

  getAMUserPerformanceFromLocalStorage() async {
    var performanceData = await PrefUtils().getAMPerformanceData();
    if (performanceData!.isNotEmpty) {
      amPerformanceModel =
          AMPerformanceModel.fromJson(jsonDecode(performanceData));
      mrList = amPerformanceModel.data!.mrData!;
    }
    setLoading(false);
  }

  getHospitalDetails() async {
    setLoadingHospital(true);
    var response = await Repository().getHospitalDetails(selectedHospital.id!);
    if (response is Success) {
      hospitalDetailsModel =
          HospitalDetailsModel.fromJson(jsonDecode(response.response));
      hospitalAlertType = hospitalDetailsModel.data!.alertType ?? '';
      setLoadingHospital(false);
    }
    if (response is Failure) {
      // onFailure('Error');
    }
  }

  getNotes() async {
    setLoadingNotes(true);
    var response = await Repository().getAllNotes(selectedHospital.id!);
    if (response is Success) {
      notesModel = NotesModel.fromJson(jsonDecode(response.response));
      debugPrint('respnsee ${notesModel.data}');
      setLoadingNotes(false);
    }
    if (response is Failure) {
      // debugPrint('respnsee1 ${notesModel.status}');
      // onFailure('Error');
    }
  }

  getAllNotifications() async {
    var response = await Repository().getAllNotification();
    if (response is Success) {
      await PrefUtils().setNotificationData(response.response);
      getNotificationsFromLocalStorage();
    }
    if (response is Failure) {
      // onFailure('Error');
    }
  }

  getNotificationsFromLocalStorage() async {
    setLoadingNotification(true);
    var notificationData = await PrefUtils().getNotificationData();
    if (notificationData!.isNotEmpty) {
      notificationModel =
          NotificationModel.fromJson(jsonDecode(notificationData));
    }
    setLoadingNotification(false);
  }

  addNote() async {
    // setLoadingNotes(true);
    // var body = {
    //   "HospitalID": selectedHospital.id,
    //   "Note": selectedNotesListModel.text,
    //   "TimeStamp": formatDate(
    //       DateTime.now(), [yyyy, '-', mm, '-', dd, 'T', hh, ':', mm, ':', ss]),
    //   "Location": "Anywhere"
    // };
    var body = {
      "HospitalID": selectedHospital.id,
      "Comment": textEditingControllerNotes.text,
    };
    var response = await Repository().addNote(body);
    hospitalAlertType = HospitalAlertType.orange;
    if (response is Success) {
      getNotes();
    }
    if (response is Failure) {
      // onFailure('Error');
    }
  }

  searchForMR(String searchText) async {
    mrList = amPerformanceModel.data!.mrData!
        .where((element) => element.name!
            .toLowerCase()
            .contains(searchText..toLowerCase().trim()))
        .toList();
    notifyListeners();
  }

  searchForHospitals(String searchText) async {
    hospitalList = performanceModel.data!.hospitals!
        .where((element) => element.name!
            .toLowerCase()
            .contains(searchText..toLowerCase().trim()))
        .toList();
    notifyListeners();
  }
}
