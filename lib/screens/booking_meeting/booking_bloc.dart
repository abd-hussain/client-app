import 'package:client_app/sevices/discount_service.dart';
import 'package:client_app/utils/currency.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

enum BookingType {
  schudule,
  instant,
}

class BookingBloc extends Bloc<DiscountService> {
  ValueNotifier<bool> applyDiscountButton = ValueNotifier<bool>(false);
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? suffixeName;
  int? categoryID;
  String? categoryName;
  String? meetingType;
  String? meetingduration;
  String? meetingtime;
  String? meetingdate;
  String? meetingcost;
  TextEditingController discountController = TextEditingController();
  ValueNotifier<String?> discountErrorMessage = ValueNotifier<String?>(null);
  BookingType bookingType = BookingType.schudule;

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      profileImageUrl = newArguments["profileImageUrl"] as String?;
      suffixeName = newArguments["suffixeName"] as String?;
      firstName = newArguments["firstName"] as String?;
      lastName = newArguments["lastName"] as String?;
      categoryName = newArguments["categoryName"] as String?;
      meetingType = newArguments["meetingType"] as String?;
      meetingduration = newArguments["meetingduration"] as String?;
      meetingtime = newArguments["meetingtime"] as String?;
      meetingdate = newArguments["meetingdate"] as String?;
      meetingcost = newArguments["meetingcost"] as String?;
      meetingcost ??= Currency().calculateHourRate(
          50,
          meetingduration == "60"
              ? Timing.hour
              : meetingduration == "30"
                  ? Timing.halfHour
                  : Timing.quarterHour);

      bookingType = newArguments["bookingType"] as BookingType;
      categoryID = newArguments["categoryID"] as int?;
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

  String calculateTotalAmount(double amount, double discount) {
    final priceDiscount = amount * discount / 100;
    final newAmount = amount - priceDiscount;
    return Currency().calculateHourRate(newAmount, Timing.hour);
  }

  @override
  onDispose() {
    applyDiscountButton.dispose();
  }
}
