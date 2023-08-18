class NotificationModel {
  String? status;
  List<Data>? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? notificationID;
  String? title;
  String? message;
  String? timeStamp;
  String? alertType;

  Data(
      {this.notificationID,
        this.title,
        this.message,
        this.timeStamp,
        this.alertType});

  Data.fromJson(Map<String, dynamic> json) {
    notificationID = json['NotificationID'];
    title = json['Title'];
    message = json['Message'];
    timeStamp = json['TimeStamp'];
    alertType = json['AlertType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationID'] = this.notificationID;
    data['Title'] = this.title;
    data['Message'] = this.message;
    data['TimeStamp'] = this.timeStamp;
    data['AlertType'] = this.alertType;
    return data;
  }
}