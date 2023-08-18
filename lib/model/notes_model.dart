class NotesModel {
  String? status;
  List<Data>? data;

  NotesModel({this.status, this.data});

  NotesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
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
  int? noteID;
  int? hospitalID;
  String? note;
  String? timeStamp;
  String? location;

  Data(
      {this.noteID, this.hospitalID, this.note, this.timeStamp, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    noteID = json['NoteID'];
    hospitalID = json['HospitalID'];
    note = json['Note'];
    timeStamp = json['TimeStamp'];
    location = json['Location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoteID'] = this.noteID;
    data['HospitalID'] = this.hospitalID;
    data['Note'] = this.note;
    data['TimeStamp'] = this.timeStamp;
    data['Location'] = this.location;
    return data;
  }
}
