import 'package:flutter/material.dart';

class ReportBloc {
  TextEditingController textController = TextEditingController();

  bool validationFields() {
    return textController.text.isNotEmpty;
  }
}
