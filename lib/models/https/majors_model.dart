class Majors {
  List<MajorsData>? data;
  String? message;

  Majors({this.data, this.message});

  Majors.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MajorsData>[];
      json['data'].forEach((v) {
        data!.add(MajorsData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MajorsData {
  int? id;
  String? name;

  MajorsData({this.id, this.name});

  MajorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
