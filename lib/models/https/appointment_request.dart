import 'package:client_app/utils/mixins.dart';

class AppointmentRequest implements Model {
  int mentorId;
  int type;
  bool isFree;
  int payment;
  CustomDate dateFrom;
  CustomDate dateTo;
  String? note;
  int? discountId;
  int? countryId;
  double mentorHourRate;
  double price;
  double totalPrice;

  AppointmentRequest({
    required this.mentorId,
    required this.type,
    required this.isFree,
    required this.payment,
    required this.dateFrom,
    required this.dateTo,
    required this.note,
    required this.discountId,
    required this.countryId,
    required this.mentorHourRate,
    required this.price,
    required this.totalPrice,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mentor_id'] = mentorId;
    data['type'] = type;
    data['payment'] = payment;
    data['is_free'] = isFree;
    data['date_from'] = dateFrom.toJson();
    data['date_to'] = dateTo.toJson();
    data['note'] = note;
    data['discount_id'] = discountId;
    data['country_id'] = countryId;
    data['mentor_hour_rate'] = mentorHourRate;
    data['price'] = price;
    data['total_price'] = totalPrice;
    return data;
  }
}

class CustomDate {
  int year;
  int month;
  int day;
  int hour;
  int min;

  CustomDate(
      {required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.min});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    data['hour'] = hour;
    data['min'] = min;
    return data;
  }
}
