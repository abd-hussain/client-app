import 'package:client_app/models/model_checker.dart';

class Appointment {
  List<AppointmentData>? data;
  String? message;

  Appointment({this.data, this.message});

  Appointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AppointmentData>[];
      json['data'].forEach((v) {
        data!.add(AppointmentData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class AppointmentData with ModelChecker {
  int? id;
  String? dateFrom;
  String? dateTo;
  int? clientId;
  int? mentorId;
  int? appointmentType;
  double? priceBeforeDiscount;
  double? priceAfterDiscount;
  int? state;
  String? noteFromClient;
  String? noteFromMentor;
  String? channelId;
  String? profileImg;
  String? mentorPrefix;
  String? mentorFirstName;
  String? mentorLastName;
  int? categoryId;
  String? categoryName;

  AppointmentData(
      {this.id,
      this.dateFrom,
      this.dateTo,
      this.mentorId,
      this.clientId,
      this.appointmentType,
      this.priceBeforeDiscount,
      this.priceAfterDiscount,
      this.state,
      this.noteFromClient,
      this.noteFromMentor,
      this.channelId,
      this.profileImg,
      this.mentorPrefix,
      this.mentorFirstName,
      this.mentorLastName,
      this.categoryId,
      this.categoryName});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    dateFrom = json['date_from'] as String?;
    dateTo = json['date_to'] as String?;
    clientId = json['client_id'] as int?;
    mentorId = json['mentor_id'] as int?;
    appointmentType = json['appointment_type'];
    priceBeforeDiscount = convertToDouble(json['price_before_discount']);
    priceAfterDiscount = convertToDouble(json['price_after_discount']);
    state = json['state'] as int?;
    noteFromClient = json['note_from_client'] as String?;
    noteFromMentor = json['note_from_mentor'] as String?;
    channelId = json['channel_id'] as String?;
    profileImg = json['profile_img'] as String?;
    mentorPrefix = json['suffixe_name'] as String?;
    mentorFirstName = json['first_name'] as String?;
    mentorLastName = json['last_name'] as String?;
    categoryId = json['category_id'] as int?;
    categoryName = json['categoryName'] as String?;
  }
}
