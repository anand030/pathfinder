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
  List<Indicators>? indicators;
  int? id;
  String? name;
  String? icon;
  String? strategy;
  String? alertType;
  GraphData? graphData;

  Data(
      {this.indicators,
        this.id,
        this.name,
        this.icon,
        this.strategy,
        this.alertType,
        this.graphData});

  Data.fromJson(Map<String, dynamic> json) {
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
    graphData = json['data'] != null ? new GraphData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.indicators != null) {
      data['Indicators'] = this.indicators!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    data['Strategy'] = this.strategy;
    data['AlertType'] = this.alertType;
    if (this.graphData != null) {
      data['data'] = this.graphData!.toJson();
    }
    return data;
  }
}

// class Indicators {
//   int? id;
//   String? name;
//   String? icon;
//   double? value;
//   String? symbol;
//
//   Indicators({this.id, this.name, this.icon, this.value, this.symbol});
//
//   Indicators.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     icon = json['Icon'];
//     value = json['Value'];
//     symbol = json['Symbol'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['Name'] = this.name;
//     data['Icon'] = this.icon;
//     data['Value'] = this.value;
//     data['Symbol'] = this.symbol;
//     return data;
//   }
// }

class GraphData {
  List<String>? labels;
  List<Datasets>? datasets;

  GraphData({this.labels, this.datasets});

  GraphData.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    if (json['datasets'] != null) {
      datasets = <Datasets>[];
      json['datasets'].forEach((v) {
        datasets!.add(new Datasets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labels'] = this.labels;
    if (this.datasets != null) {
      data['datasets'] = this.datasets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datasets {
  List<int>? data;
  String? label;

  Datasets({this.data, this.label});

  Datasets.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<int>();
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['label'] = this.label;
    return data;
  }
}
