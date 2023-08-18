import 'package:pathfinder/model/performance_model.dart';

class AMPerformanceModel {
  String? status;
  Data? data;

  AMPerformanceModel({this.status, this.data});

  AMPerformanceModel.fromJson(Map<String, dynamic> json) {
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
  List<MRData>? mrData;
  List<TerritorySummary>? territorySummary;

  Data({this.mrData, this.territorySummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Territory_Detailed'] != null) {
      mrData = <MRData>[];
      json['Territory_Detailed'].forEach((v) {
        mrData!.add(new MRData.fromJson(v));
      });
    }
    if (json['Territory_Summary'] != null) {
      territorySummary = <TerritorySummary>[];
      json['Territory_Summary'].forEach((v) {
        territorySummary!.add(new TerritorySummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mrData != null) {
      data['Territory_Detailed'] = this.mrData!.map((v) => v.toJson()).toList();
    }
    if (this.territorySummary != null) {
      data['Territory_Summary'] =
          this.territorySummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MRData {
  List<Indicators>? indicators;
  int? id;
  String? name;
  String? areaCode;
  String? alertType;

  MRData({this.indicators, this.id, this.name, this.areaCode, this.alertType});

  MRData.fromJson(Map<String, dynamic> json) {
    if (json['Indicators'] != null) {
      indicators = <Indicators>[];
      json['Indicators'].forEach((v) {
        indicators!.add(new Indicators.fromJson(v));
      });
    }
    id = json['Id'];
    name = json['Name'];
    areaCode = json['AreaCode'];
    alertType = json['AlertType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.indicators != null) {
      data['Indicators'] = this.indicators!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['AreaCode'] = this.areaCode;
    data['AlertType'] = this.alertType;
    return data;
  }
}

// class Indicators {
//   int? id;
//   String? name;
//   Null? icon;
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

class TerritorySummary {
  int? id;
  String? name;
  String? icon;
  double? value;

  TerritorySummary({this.id, this.name, this.icon, this.value});

  TerritorySummary.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    data['Value'] = this.value;
    return data;
  }
}
