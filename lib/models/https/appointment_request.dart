import 'package:client_app/utils/mixins.dart';

class AppointmentRequest implements Model {
  int mentorId;
  int type;
  bool isFree;
  String currency;
  double price;
  double totalPrice;
  double mentorHourRate;
  int discountId;
  CustomDate dateFrom;
  CustomDate dateTo;
  String? note;

  AppointmentRequest({
    required this.mentorId,
    required this.type,
    required this.isFree,
    required this.currency,
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
    data['isFree'] = isFree;
    data['currency'] = currency;
    data['price'] = price;
    data['totalPrice'] = totalPrice;
    data['discountId'] = discountId;
    data['dateFrom'] = dateFrom.toJson();
    data['dateTo'] = dateTo.toJson();
    data['note'] = note;
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
