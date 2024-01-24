import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment_request.dart';
import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/discount_service.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

enum BookingType {
  schudule,
  instant,
}

class BookingBloc extends Bloc<DiscountService> {
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  ValueNotifier<String> discountErrorMessage = ValueNotifier<String>("");
  ValueNotifier<bool> applyDiscountButton = ValueNotifier<bool>(false);

  String? scheduleMentorProfileImageUrl;
  String? scheduleMentorSuffixName;
  String? scheduleMentorFirstName;
  String? scheduleMentorLastName;
  int? mentorId;
  double? mentorHourRate;
  String? mentorCurrency;
  String? scheduleMentorGender;
  String? mentorCountryName;
  String? mentorCountryFlag;
  DateTime? mentorMeetingdate;
  int? mentorMeetingtime;
  String? meetingDay;
  bool meetingFreeCall = false;

  int? categoryID;
  String? categoryName;
  int? majorID;
  String? majorName;
  Timing? meetingduration;
  BookingType? bookingType;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  bool enablePayButton = false;

  ValueNotifier<List<MentorInfoAvaliableResponseData>?> avaliableMentors =
      ValueNotifier<List<MentorInfoAvaliableResponseData>?>(null);

  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  void handleReadingArguments(BuildContext context,
      {required Object? arguments}) {
    loadingStatus.value = LoadingStatus.inprogress;
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      bookingType = newArguments["bookingType"] as BookingType;
      categoryID = newArguments["categoryID"] as int?;
      categoryName = newArguments["categoryName"] as String?;
      meetingduration = newArguments["meetingduration"] as Timing?;
      majorName = newArguments["majorName"] as String?;
      majorID = newArguments["majorID"] as int?;

      if (bookingType == BookingType.instant) {
        _checkingAvaliableMentors(categoryID!, majorID!);
      } else {
        mentorId = newArguments["mentor_id"] as int?;
        scheduleMentorProfileImageUrl =
            newArguments["profileImageUrl"] as String? ?? "";
        scheduleMentorSuffixName = newArguments["suffixeName"] as String?;
        scheduleMentorFirstName = newArguments["firstName"] as String?;
        scheduleMentorLastName = newArguments["lastName"] as String?;
        mentorHourRate = newArguments["hourRate"] as double?;
        mentorCurrency = newArguments["currency"] as String?;
        scheduleMentorGender = newArguments["gender"] as String?;
        mentorCountryName = newArguments["countryName"] as String?;
        mentorCountryFlag = newArguments["countryFlag"] as String?;
        mentorMeetingdate = newArguments["meetingDate"] as DateTime?;
        mentorMeetingtime = newArguments["meetingTime"] as int?;
        meetingFreeCall = newArguments["freeCall"] as bool;
        meetingDay = meetingDayNamed(mentorMeetingdate);
        enablePayButton = true;
        loadingStatus.value = LoadingStatus.finish;
      }
    }
  }

  String? meetingDayNamed(DateTime? date) {
    if (date != null) {
      var dayName = DateFormat('EEEE').format(date);
      return box.get(DatabaseFieldConstant.language) == "en"
          ? dayName
          : DayTime().convertDayToArabic(dayName);
    }
    return null;
  }

  String? meetingDate(DateTime? date) {
    if (date != null) {
      final format = DateFormat('yyyy/MM/dd');
      return format.format(date);
    }
    return null;
  }

  String? meetingTime(int? time) {
    if (time != null) {
      return DayTime().convertingTimingWithMinToRealTime(time, 0);
    }
    return null;
  }

  double? calculateMeetingCost(
      {required double? hourRate,
      required Timing? duration,
      required bool freeCall}) {
    if (hourRate == null || duration == null) {
      return 0.0;
    } else {
      switch (duration) {
        case Timing.quarterHour:
          if (freeCall) {
            return 0.0;
          } else {
            return (hourRate / 4);
          }

        case Timing.halfHour:
          return (hourRate / 2);
        case Timing.threeQuarter:
          return (hourRate - (hourRate / 4));
        case Timing.hour:
          return hourRate;
      }
    }
  }

  double calculateTotalAmountVariable = 0.0;
  double calculateTotalAmount(
      {required double? hourRate,
      required Timing? duration,
      required String discount,
      required bool freeCall}) {
    if (hourRate == null || duration == null) {
      calculateTotalAmountVariable = 0.0;
      return calculateTotalAmountVariable;
    } else {
      double newDiscount = 0;

      if (discount != "" && discount != "error") {
        newDiscount = double.parse(discount);
      }

      switch (duration) {
        case Timing.quarterHour:
          if (freeCall) {
            calculateTotalAmountVariable = 0;
            return calculateTotalAmountVariable;
          } else {
            if (newDiscount > 0) {
              calculateTotalAmountVariable =
                  (hourRate / 4) - ((hourRate / 4) * (newDiscount / 100));
              return calculateTotalAmountVariable;
            } else {
              calculateTotalAmountVariable = (hourRate / 4);
              return calculateTotalAmountVariable;
            }
          }
        case Timing.halfHour:
          if (newDiscount > 0) {
            calculateTotalAmountVariable =
                (hourRate / 2) - ((hourRate / 2) * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = (hourRate / 2);
            return calculateTotalAmountVariable;
          }

        case Timing.threeQuarter:
          if (newDiscount > 0) {
            calculateTotalAmountVariable = (hourRate - (hourRate / 4)) -
                ((hourRate - (hourRate / 4)) * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = (hourRate - (hourRate / 4));
            return calculateTotalAmountVariable;
          }

        case Timing.hour:
          if (newDiscount > 0) {
            calculateTotalAmountVariable =
                hourRate - (hourRate * (newDiscount / 100));
            return calculateTotalAmountVariable;
          } else {
            calculateTotalAmountVariable = hourRate;
            return calculateTotalAmountVariable;
          }
      }
    }
  }

  _checkingAvaliableMentors(int catID, int majorID) {
    locator<MentorService>()
        .getMentorAvaliable(categoryID: catID, majorID: majorID)
        .then((value) {
      if (value.data != null) {
        avaliableMentors.value = value.data;
        mentorId = value.data![0].id;
        mentorHourRate = value.data![0].hourRate;
        mentorCurrency = value.data![0].currency;
        mentorMeetingdate =
            DateFormat("yyyy-MM-dd").parse(value.data![0].date!);
        meetingDay = meetingDayNamed(mentorMeetingdate);
        mentorMeetingtime = value.data![0].hour!;
        meetingFreeCall = false;
        enablePayButton = true;

        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  Future<dynamic> bookMeetingRequest(
      {required AppointmentRequest appointment}) async {
    return await locator<AppointmentsService>()
        .bookNewAppointments(appointment: appointment);
  }

  handleLisinnerOfDiscountController() {
    discountController.addListener(() {
      applyDiscountButton.value = false;
      discountErrorMessage.value = "";
      if (discountController.text.length == 6) {
        applyDiscountButton.value = true;
      }
    });
  }

  void verifyCode() {
    service.discount(discountController.text).then((value) {
      if (value.data == null) {
        discountErrorMessage.value = "error";
      } else {
        discountErrorMessage.value = value.data!.percentValue!.toString();
      }
    });
  }

  double calculateDiscountPercent(String snapshot) {
    if (snapshot == "") {
      return 0.0;
    } else if (snapshot == "error") {
      return 0.0;
    } else {
      return double.tryParse(snapshot) ?? 0.0;
    }
  }

  String meetingDurationParser(Timing duration) {
    switch (duration) {
      case Timing.quarterHour:
        return "15";
      case Timing.halfHour:
        return "30";
      case Timing.threeQuarter:
        return "45";
      case Timing.hour:
        return "60";
    }
  }

  @override
  onDispose() {
    applyDiscountButton.dispose();
  }

  getMeetingDay() {}
}
