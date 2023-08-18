class PerformanceModel {
  String? status;
  Data? data;

  PerformanceModel({this.status, this.data});

  PerformanceModel.fromJson(Map<String, dynamic> json) {
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
  List<Hospitals>? hospitals;
  List<TerritorySummary>? territorySummary;

  Data({this.hospitals, this.territorySummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Hospitals'] != null) {
      hospitals = <Hospitals>[];
      json['Hospitals'].forEach((v) {
        hospitals!.add(new Hospitals.fromJson(v));
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
    if (this.hospitals != null) {
      data['Hospitals'] = this.hospitals!.map((v) => v.toJson()).toList();
    }
    if (this.territorySummary != null) {
      data['Territory_Summary'] =
          this.territorySummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospitals {
  List<Indicators>? indicators;
  int? id;
  String? name;
  String? icon;
  String? strategy;
  String? alertType;

  Hospitals(
      {this.indicators,
      this.id,
      this.name,
      this.icon,
      this.strategy,
      this.alertType});

  Hospitals.fromJson(Map<String, dynamic> json) {
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

class Indicators {
  int? id;
  String? name;
  String? icon;
  double? value;
  String? symbol;

  Indicators({this.id, this.name, this.icon, this.value, this.symbol});

  Indicators.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
    value = json['Value'];
    symbol = json['Symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    data['Value'] = this.value;
    data['Symbol'] = this.symbol;
    return data;
  }
}

class TerritorySummary {
  int? id;
  String? name;
  String? icon;
  double? value;
  String? symbol;

  TerritorySummary({this.id, this.name, this.icon, this.value, this.symbol});

  TerritorySummary.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    icon = json['Icon'];
    value = json['Value'];
    symbol = json['Symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Icon'] = this.icon;
    data['Value'] = this.value;
    data['Symbol'] = this.symbol;
    return data;
  }
}
