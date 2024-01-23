import 'dart:ffi';

import 'package:client_app/locator.dart';
import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/sevices/discount_service.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  int? scheduleMentorId;
  Double? scheduleMentorHourRate;
  String? scheduleMentorCurrency;
  String? scheduleMentorGender;
  String? scheduleMentorCountryName;
  String? scheduleMentorCountryFlag;
  DateTime? scheduleMentorMeetingdate;
  int? scheduleMentorMeetingtime;

  int? categoryID;
  String? categoryName;
  int? majorID;
  String? majorName;
  Timing? meetingduration;

  String? meetingdate;
  String? meetingtime;

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<List<MentorInfoAvaliableResponseData>?> avaliableMentors =
      ValueNotifier<List<MentorInfoAvaliableResponseData>?>(null);

  ValueNotifier<MentorInfoAvaliableResponseData?> selectedMentors =
      ValueNotifier<MentorInfoAvaliableResponseData?>(null);

  ValueNotifier<BookingType> bookingType = ValueNotifier<BookingType>(BookingType.schudule);

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      bookingType.value = newArguments["bookingType"] as BookingType;
      categoryID = newArguments["categoryID"] as int?;
      categoryName = newArguments["categoryName"] as String?;
      meetingduration = newArguments["meetingduration"] as Timing?;
      majorName = newArguments["majorName"] as String?;
      majorID = newArguments["majorID"] as int?;

      if (bookingType.value == BookingType.instant) {
        _checkingAvaliableMentors(categoryID!, majorID!);
      } else {
        scheduleMentorId = newArguments["mentor_id"] as int?;
        scheduleMentorProfileImageUrl = newArguments["profileImageUrl"] as String? ?? "";
        scheduleMentorSuffixName = newArguments["suffixeName"] as String?;
        scheduleMentorFirstName = newArguments["firstName"] as String?;
        scheduleMentorLastName = newArguments["lastName"] as String?;
        scheduleMentorHourRate = newArguments["hourRate"] as Double?;
        scheduleMentorCurrency = newArguments["currency"] as String?;
        scheduleMentorGender = newArguments["gender"] as String?;
        scheduleMentorCountryName = newArguments["countryName"] as String?;
        scheduleMentorCountryFlag = newArguments["countryFlag"] as String?;
        scheduleMentorMeetingdate = newArguments["meetingDate"] as DateTime?;
        scheduleMentorMeetingtime = newArguments["meetingTime"] as int?;

        // meetingcost ??= Currency().calculateHourRate(
        //     50,
        //     meetingduration == "60"
        //         ? Timing.hour
        //         : meetingduration == "30"
        //             ? Timing.halfHour
        //             : Timing.quarterHour,
        //     "JD");
      }
    }
  }

  double calculateMeetingCost() {
    return 0.0;
  }

  double calculateTotalAmount() {
    // double.parse(Currency().getHourRateWithoutCurrency(bloc.meetingcost!)),
    //                           snapshot == null || snapshot == "error" ? 0 : double.parse(snapshot))

    return 0.0;
  }

  String? meetingDay() {
    // return meetingday != null
    //     ? box.get(DatabaseFieldConstant.language) == "en"
    //         ? meetingday!
    //         : DayTime().convertDayToArabic(meetingday!)
    //     : null;
    return null;
  }

  String getCurrency() {
    // return meetingday != null
    //     ? box.get(DatabaseFieldConstant.language) == "en"
    //         ? meetingday!
    //         : DayTime().convertDayToArabic(meetingday!)
    //     : null;
    return "\$";
  }

  // double calculateTotalAmountWithoutCurrency(double amount, double discount) {
  //   final priceDiscount = amount * discount / 100;
  //   return amount - priceDiscount;
  // }

  // String calculateTotalAmount(double amount, double discount) {
  //   return Currency().calculateHourRate(calculateTotalAmountDouble(amount, discount), Timing.hour, "JD");
  // }

  // double calculateTotalAmountDouble(double amount, double discount) {
  //   final priceDiscount = amount * discount / 100;
  //   final newAmount = amount - priceDiscount;
  //   return newAmount;
  // }

  _checkingAvaliableMentors(int catID, int majorID) {
    locator<MentorService>().getMentorAvaliable(categoryID: catID, majorID: majorID).then((value) {
      if (value.data != null) {
        avaliableMentors.value = value.data;
        // mentorProfileImageUrl = value.data!.profileImg;
        // mentorSuffixName = value.data!.suffixeName!;
        // mentorFirstName = value.data!.firstName!;
        // mentorLastName = value.data!.lastName!;
        // mentorId = value.data!.id!;

        // meetingcost = Currency().calculateHourRate(
        //     value.data!.hourRate!,
        //     meetingduration == "60"
        //         ? Timing.hour
        //         : meetingduration == "45"
        //             ? Timing.threeQuarter
        //             : meetingduration == "30"
        //                 ? Timing.halfHour
        //                 : Timing.quarterHour,
        //     "JD");

        // meetingtime = DayTime().convertingTimingToRealTime(value.data!.hour!);
        // meetingdate = value.data!.date!;
        // meetingday = value.data!.day!;

        // checkingAvaliableMentors.value = AvaliableMentorStatus.found;
        // final backup = discountErrorMessage.value;
        // discountErrorMessage.value = "update";
        // discountErrorMessage.value = backup;
      }
    });
  }

  // Future<dynamic> bookMeetingRequest({required AppointmentRequest appointment}) async {
  //   return await locator<AppointmentsService>().bookNewAppointments(appointment: appointment);
  // }

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
