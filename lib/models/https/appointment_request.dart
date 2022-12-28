import 'package:client_app/utils/mixins.dart';

class AppointmentRequest implements Model {
  int mentorId;
  double priceWithoutDescount;
  int? descountId;
  CustomDate dateFrom;
  CustomDate dateTo;

  AppointmentRequest(
      {required this.mentorId,
      required this.priceWithoutDescount,
      this.descountId,
      required this.dateFrom,
      required this.dateTo});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mentorId'] = mentorId;
    data['priceWithoutDescount'] = priceWithoutDescount;
    data['descountId'] = descountId;
    data['dateFrom'] = dateFrom.toJson();
    data['dateTo'] = dateTo.toJson();
    return data;
  }
}

class CustomDate {
  int year;
  int month;
  int day;
  int hour;
  int min;

  CustomDate({required this.year, required this.month, required this.day, required this.hour, required this.min});

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
