import 'package:client_app/models/https/report_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class ReportService with Service {
  Future<dynamic> addSuggestion({required ReportRequest reportData}) async {
    FormData? formData;
    String fileName1 = "";
    String fileName2 = "";
    String fileName3 = "";
    if (reportData.image1 != null) {
      fileName1 = reportData.image1!.path.split('/').last;
    }
    if (reportData.image2 != null) {
      fileName2 = reportData.image2!.path.split('/').last;
    }
    if (reportData.image3 != null) {
      fileName3 = reportData.image3!.path.split('/').last;
    }

    formData = FormData.fromMap({
      "content": MultipartFile.fromString(reportData.content),
      "client_user_id": MultipartFile.fromString(reportData.userId ?? ""),
      "attach1": reportData.image1 != null
          ? await MultipartFile.fromFile(reportData.image1!.path, filename: fileName1)
          : MultipartFile.fromString(""),
      "attach2": reportData.image2 != null
          ? await MultipartFile.fromFile(reportData.image2!.path, filename: fileName2)
          : MultipartFile.fromString(""),
      "attach3": reportData.image3 != null
          ? await MultipartFile.fromFile(reportData.image3!.path, filename: fileName3)
          : MultipartFile.fromString(""),
    });

    return await repository.callRequest(
        requestType: RequestType.post, methodName: MethodNameConstant.reportSuggestion, formData: formData);
  }

  Future<dynamic> addBugIssue({required ReportRequest reportData}) async {
    FormData? formData;
    String fileName1 = "";
    String fileName2 = "";
    String fileName3 = "";
    if (reportData.image1 != null) {
      fileName1 = reportData.image1!.path.split('/').last;
    }
    if (reportData.image2 != null) {
      fileName2 = reportData.image2!.path.split('/').last;
    }
    if (reportData.image3 != null) {
      fileName3 = reportData.image3!.path.split('/').last;
    }

    formData = FormData.fromMap({
      "content": MultipartFile.fromString(reportData.content),
      "client_user_id": MultipartFile.fromString(reportData.userId ?? ""),
      "attach1": reportData.image1 != null
          ? await MultipartFile.fromFile(reportData.image1!.path, filename: fileName1)
          : MultipartFile.fromString(""),
      "attach2": reportData.image2 != null
          ? await MultipartFile.fromFile(reportData.image2!.path, filename: fileName2)
          : MultipartFile.fromString(""),
      "attach3": reportData.image3 != null
          ? await MultipartFile.fromFile(reportData.image3!.path, filename: fileName3)
          : MultipartFile.fromString(""),
    });

    return await repository.callRequest(
        requestType: RequestType.post, methodName: MethodNameConstant.reportIssue, formData: formData);
  }

  Future<dynamic> reportEvent({required int eventId}) async {
    return await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportEvent,
      queryParam: {"eventId": eventId, "isMentor": false},
    );
  }
}
