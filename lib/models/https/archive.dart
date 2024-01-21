import 'package:client_app/models/model_checker.dart';

class Archive {
  List<ArchiveData>? data;
  String? message;

  Archive({this.data, this.message});

  Archive.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ArchiveData>[];
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
  int? appointmentId;
  String? attachment;
  String? profileImg;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? gender;
  String? countryName;
  String? categoryName;
  int? appointmentType;
  String? dateFrom;
  String? dateTo;
  int? state;
  int? discountId;
  bool? isFree;
  double? price;
  double? discountedPrice;
  String? currency;
  double? mentorHourRate;
  String? noteFromClient;
  String? noteFromMentor;
  String? mentorJoinCall;
  String? clientJoinCall;
  String? mentorDateOfClose;
  String? clientDateOfClose;

  ArchiveData(
      {this.id,
      this.clientId,
      this.mentorId,
      this.appointmentId,
      this.attachment,
      this.profileImg,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.gender,
      this.countryName,
      this.categoryName,
      this.appointmentType,
      this.dateFrom,
      this.dateTo,
      this.state,
      this.discountId,
      this.isFree,
      this.price,
      this.discountedPrice,
      this.currency,
      this.mentorHourRate,
      this.noteFromClient,
      this.noteFromMentor,
      this.mentorJoinCall,
      this.clientJoinCall,
      this.mentorDateOfClose,
      this.clientDateOfClose});

  ArchiveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    appointmentId = json['appointment_id'];
    attachment = json['attachment'];
    profileImg = json['profile_img'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    countryName = json['countryName'];
    categoryName = json['categoryName'];
    appointmentType = json['appointment_type'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    state = json['state'];
    discountId = json['discount_id'];
    isFree = json['is_free'];
    price = convertToDouble(json['price']);
    discountedPrice = convertToDouble(json['discounted_price']);
    currency = json['currency'];
    mentorHourRate = convertToDouble(json['mentor_hour_rate']);
    noteFromClient = json['note_from_client'];
    noteFromMentor = json['note_from_mentor'];
    mentorJoinCall = json['mentor_join_call'];
    clientJoinCall = json['client_join_call'];
    mentorDateOfClose = json['mentor_date_of_close'];
    clientDateOfClose = json['client_date_of_close'];
  }
}
