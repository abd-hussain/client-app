import 'dart:async';
import 'package:client_app/locator.dart';
import 'package:client_app/models/https/appointment_request.dart';
import 'package:client_app/sevices/appointments_service.dart';
import 'package:client_app/sevices/discount_service.dart';
import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/day_time.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum BookingType {
  schudule,
  instant,
}

enum AvaliableMentorStatus {
  searching,
  found,
  notFound,
}

class BookingBloc extends Bloc<DiscountService> {
  ValueNotifier<bool> applyDiscountButton = ValueNotifier<bool>(false);
  int? mentorId;
  String? mentorSuffixName;
  String? mentorFirstName;
  String? mentorLastName;
  String? mentorProfileImageUrl;

  String? categoryName;
  String? meetingduration;
  String? meetingtime;
  String? meetingdate;
  String? meetingday;
  String? meetingcost;
  TextEditingController noteController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  ValueNotifier<String?> discountErrorMessage = ValueNotifier<String?>(null);
  BookingType bookingType = BookingType.schudule;
  ValueNotifier<AvaliableMentorStatus> checkingAvaliableMentors =
      ValueNotifier<AvaliableMentorStatus>(AvaliableMentorStatus.searching);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      mentorProfileImageUrl = newArguments["profileImageUrl"] as String?;
      mentorSuffixName = newArguments["suffixeName"] as String?;
      mentorFirstName = newArguments["firstName"] as String?;
      mentorLastName = newArguments["lastName"] as String?;
      mentorId = newArguments["mentor_id"] as int?;
      categoryName = newArguments["categoryName"] as String?;
      meetingduration = newArguments["meetingduration"] as String?;
      meetingtime = newArguments["meetingtime"] as String?;
      meetingdate = newArguments["meetingdate"] as String?;
      meetingday = newArguments["meetingday"] as String?;
      meetingcost = newArguments["meetingcost"] as String?;
      meetingcost ??= Currency().calculateHourRate(
          50,
          meetingduration == "60"
              ? Timing.hour
              : meetingduration == "30"
                  ? Timing.halfHour
                  : Timing.quarterHour);

      bookingType = newArguments["bookingType"] as BookingType;
      int? categoryID = newArguments["categoryID"] as int?;

      if (bookingType == BookingType.instant) {
        _checkingAvaliableMentors(categoryID!);
      }
    }
  }

  handleLisinnerOfDiscountController() {
    discountController.addListener(() {
      applyDiscountButton.value = false;
      discountErrorMessage.value = null;
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
        discountErrorMessage.value = value.data.toString();
      }
    });
  }

  double calculateTotalAmountWithoutCurrency(double amount, double discount) {
    final priceDiscount = amount * discount / 100;
    return amount - priceDiscount;
  }

  String calculateTotalAmount(double amount, double discount) {
    return Currency().calculateHourRate(calculateTotalAmountDouble(amount, discount), Timing.hour);
  }

  double calculateTotalAmountDouble(double amount, double discount) {
    final priceDiscount = amount * discount / 100;
    final newAmount = amount - priceDiscount;
    return newAmount;
  }

  _checkingAvaliableMentors(int catID) {
    checkingAvaliableMentors.value = AvaliableMentorStatus.searching;
    locator<MentorService>().getmentorAvaliable(categoryID: catID).then((value) {
      if (value.data != null) {
        mentorProfileImageUrl = value.data!.profileImg;
        mentorSuffixName = value.data!.suffixeName!;
        mentorFirstName = value.data!.firstName!;
        mentorLastName = value.data!.lastName!;
        mentorId = value.data!.id!;

        meetingcost = Currency().calculateHourRate(
            value.data!.hourRate!,
            meetingduration == "60"
                ? Timing.hour
                : meetingduration == "45"
                    ? Timing.threeQuarter
                    : meetingduration == "30"
                        ? Timing.halfHour
                        : Timing.quarterHour);

        meetingtime = DayTime().convertingTimingToRealTime(value.data!.hour!);
        meetingdate = value.data!.date!;
        meetingday = value.data!.day!;

        checkingAvaliableMentors.value = AvaliableMentorStatus.found;
        final backup = discountErrorMessage.value;
        discountErrorMessage.value = "update";
        discountErrorMessage.value = backup;
      } else {
        checkingAvaliableMentors.value = AvaliableMentorStatus.notFound;
      }
    });
  }

  Future<dynamic> bookMeetingRequest({required AppointmentRequest appointment}) async {
    return await locator<AppointmentsService>().bookNewAppointments(appointment: appointment);
  }

  @override
  onDispose() {
    applyDiscountButton.dispose();
  }
}
