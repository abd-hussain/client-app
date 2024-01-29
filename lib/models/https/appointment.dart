import 'package:client_app/models/model_checker.dart';

enum AppointmentsState {
  active,
  mentorCancel,
  clientCancel,
  clientMiss,
  mentorMiss,
  completed
}

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
  int? mentorId;
  int? appointmentType;
  int? state;
  int? discountId;
  bool? isFree;
  double? price;
  double? totalPrice;
  String? currency;
  double? mentorHourRate;
  String? noteFromClient;
  String? noteFromMentor;
  String? channelId;
  String? profileImg;
  String? suffixeName;
  String? firstName;
  String? lastName;
  List<String>? speakingLanguage;
  String? countryName;
  String? categoryName;
  String? flagImage;
  int? gender;

  AppointmentData(
      {this.id,
      this.dateFrom,
      this.dateTo,
      this.mentorId,
      this.appointmentType,
      this.state,
      this.discountId,
      this.isFree,
      this.price,
      this.totalPrice,
      this.currency,
      this.mentorHourRate,
      this.noteFromClient,
      this.noteFromMentor,
      this.channelId,
      this.profileImg,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.speakingLanguage,
      this.countryName,
      this.categoryName,
      this.gender,
      this.flagImage});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    mentorId = json['mentor_id'];
    appointmentType = json['appointment_type'];
    state = json['state'];
    discountId = json['discount_id'];
    isFree = json['is_free'];
    price = convertToDouble(json['price']);
    totalPrice = convertToDouble(json['total_price']);
    currency = json['currency'];
    mentorHourRate = convertToDouble(json['mentor_hour_rate']);
    noteFromClient = convertToString(json['note_from_client']);
    noteFromMentor = convertToString(json['note_from_mentor']);
    channelId = json['channel_id'];
    profileImg = json['profile_img'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    speakingLanguage = json['speaking_language'].cast<String>();
    countryName = json['countryName'];
    categoryName = json['categoryName'];
    gender = json['gender'];
    flagImage = json['flag_image'];
  }
}
