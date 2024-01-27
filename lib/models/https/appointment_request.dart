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
  int? currencyId;
  double mentorHourRate;
  double price;
  double totalPrice;

  AppointmentRequest({
    required this.mentorId,
    required this.type,
    required this.isFree,
    required this.payment,
    required this.currencyId,
    required this.price,
    required this.totalPrice,
    required this.mentorHourRate,
    required this.discountId,
    required this.dateFrom,
    required this.dateTo,
    required this.note,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mentorId'] = mentorId;
    data['type'] = type;
    data['is_free'] = isFree;
    data['payment'] = payment;
    data['dateFrom'] = dateFrom.toJson();
    data['dateTo'] = dateTo.toJson();
    data['note'] = note;
    data['discount_id'] = discountId;
    data['currency_id'] = currencyId;
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
