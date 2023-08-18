import 'package:pathfinder/model/performance_model.dart';

class HospitalDetailsModel {
  String? status;
  Data? data;

  HospitalDetailsModel({this.status, this.data});

  HospitalDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Null>? data;
  List<Indicators>? indicators;
  int? id;
  String? name;
  String? icon;
  String? strategy;
  String? alertType;

  Data(
      {this.data,
      this.indicators,
      this.id,
      this.name,
      this.icon,
      this.strategy,
      this.alertType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Null>[];
      // json['data'].forEach((v) {
      //   data!.add(new Null.fromJson(v));
      // });
    }
    if (json['Indicators'] != null) {
      indicators = <Indicators>[];
      json['Indicators'].forEach((v) {
        indicators!.add(new Indicators.fromJson(v));
      });
    }
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
    strategy = json['Strategy'];
    alertType = json['AlertType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    if (this.indicators != null) {
      data['Indicators'] = this.indicators!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    data['Strategy'] = this.strategy;
    data['AlertType'] = this.alertType;
    return data;
  }
}

// class Indicators {
//   int? id;
//   String? name;
//   String? icon;
//   double? value;
//
//   Indicators({this.id, this.name, this.icon, this.value});
//
//   Indicators.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     icon = json['Icon'];
//     value = json['Value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['Icon'] = this.icon;
//     data['Value'] = this.value;
//     return data;
//   }
// }
