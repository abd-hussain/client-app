import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';

class ReportBloc {
  TextEditingController textController = TextEditingController();
  ReportPageType? pageType;
  bool validationFields() {
    return textController.text.isNotEmpty;
  }

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      pageType = newArguments[AppConstant.argument1] as ReportPageType?;
    }
  }
}
