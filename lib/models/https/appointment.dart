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

class AppointmentData {
  int? id;
  int? mentorId;
  int? clientId;
  String? dateFrom;
  String? dateTo;
  double? priceBeforeDiscount;
  int? discountId;

  AppointmentData(
      {this.id, this.mentorId, this.clientId, this.discountId, this.dateFrom, this.dateTo, this.priceBeforeDiscount});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mentorId = json['mentor_id'];
    clientId = json['client_id'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    discountId = json['discount_id'];
    priceBeforeDiscount = json['price_before_discount'];
  }
}
