import 'package:client_app/sevices/mentor_service.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';

class BookingBloc extends Bloc<MentorService> {
  ValueNotifier<bool> applyDiscountButton = ValueNotifier<bool>(false);
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? suffixeName;
  String? categoryName;
  String? meetingType;
  String? meetingduration;
  String? meetingtime;
  String? meetingdate;
  String? meetingcost;
  TextEditingController discountController = TextEditingController();

  void handleReadingArguments(BuildContext context, {required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      profileImageUrl = newArguments["profileImageUrl"] as String;
      suffixeName = newArguments["suffixeName"] as String;
      firstName = newArguments["firstName"] as String;
      lastName = newArguments["lastName"] as String;
      categoryName = newArguments["categoryName"] as String;
      meetingType = newArguments["meetingType"] as String;
      meetingduration = newArguments["meetingduration"] as String;
      meetingtime = newArguments["meetingtime"] as String;
      meetingdate = newArguments["meetingdate"] as String;
      meetingcost = newArguments["meetingcost"] as String;
    }
  }

  handleLisinnerOfDiscountController() {
    discountController.addListener(() {
      applyDiscountButton.value = false;
      if (discountController.text.length == 6) {
        applyDiscountButton.value = true;
      }
    });
  }

  @override
  onDispose() {
    applyDiscountButton.dispose();
  }
}
