import 'dart:io';

import 'package:client_app/models/https/report_request.dart';
import 'package:client_app/screens/report/report_screen.dart';
import 'package:client_app/sevices/report_service.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/enums/loading_status.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReportBloc extends Bloc<ReportService> {
  var box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController textController = TextEditingController();
  ReportPageType? pageType;
  ValueNotifier<bool> enableSubmitBtn = ValueNotifier<bool>(false);
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  File? attach1;
  File? attach2;
  File? attach3;

  void validationFields() {
    enableSubmitBtn.value = false;

    if (textController.text.isNotEmpty) {
      enableSubmitBtn.value = true;
    }
  }

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      pageType = newArguments[AppConstant.argument1] as ReportPageType?;
    }
  }

  Future<dynamic> callRequest(BuildContext context) async {
    final model = ReportRequest(
      content: textController.text,
      image1: attach1,
      image2: attach2,
      image3: attach3,
    );

    if (box.get(DatabaseFieldConstant.userid) != null) {
      model.userId = box.get(DatabaseFieldConstant.userid).toString();
    }

    if (pageType == ReportPageType.issue) {
      return await service.addBugIssue(reportData: model);
    } else {
      return await service.addSuggestion(reportData: model);
    }
  }

  @override
  onDispose() {
    attach1 = null;
    attach2 = null;
    attach3 = null;
    textController.dispose();
    enableSubmitBtn.dispose();
    loadingStatus.dispose();
  }
}
