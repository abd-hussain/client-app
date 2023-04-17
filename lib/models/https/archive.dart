import 'package:client_app/models/model_checker.dart';

class Archive {
  List<ArchiveData>? data;
  String? message;

  Archive({this.data, this.message});

  Archive.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ArchiveData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class ArchiveData with ModelChecker {
  int? id;
  int? clientId;
  int? mentorId;
  int? appointmentType;
  String? dateFrom;
  String? dateTo;
  double? priceBeforeDiscount;
  double? priceAfterDiscount;
  String? noteFromClient;
  String? noteFromMentor;
  String? attachment;
  String? profileImg;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? categoryId;
  String? categoryName;

  ArchiveData(
      {this.id,
      this.clientId,
      this.mentorId,
      this.appointmentType,
      this.dateFrom,
      this.dateTo,
      this.priceBeforeDiscount,
      this.priceAfterDiscount,
      this.noteFromClient,
      this.noteFromMentor,
      this.attachment,
      this.profileImg,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.categoryId,
      this.categoryName});

  ArchiveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    appointmentType = json['appointment_type'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    priceBeforeDiscount = convertToDouble(json['price_before_discount']);
    priceAfterDiscount = convertToDouble(json['price_after_discount']);
    noteFromClient = json['note_from_client'];
    noteFromMentor = json['note_from_mentor'];
    attachment = json['attachment'];
    profileImg = json['profile_img'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    categoryId = json['category_id'];
    categoryName = json['categoryName'];
  }
}
