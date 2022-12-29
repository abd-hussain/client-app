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
  String? dateFrom;
  int? id;
  int? mentorId;
  double? priceBeforeDiscount;
  String? createdAt;
  String? dateTo;
  int? clientId;
  int? discountId;

  AppointmentData(
      {this.dateFrom,
      this.id,
      this.mentorId,
      this.priceBeforeDiscount,
      this.createdAt,
      this.dateTo,
      this.clientId,
      this.discountId});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    dateFrom = json['date_from'] as String?;
    id = json['id'];
    mentorId = json['mentor_id'] as int?;
    priceBeforeDiscount = convertToDouble(json['price_before_discount']);
    createdAt = json['created_at'] as String?;
    dateTo = json['date_to'] as String?;
    clientId = json['client_id'] as int?;
    discountId = json['discount_id'] as int?;
  }
}
