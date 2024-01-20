import 'package:client_app/models/https/report_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class ReportService with Service {
  Future<dynamic> addSuggestion({required ReportRequest reportData}) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry("content", reportData.content));

    if (reportData.userId != null) {
      formData.fields.add(MapEntry("client_user_id", reportData.userId!));
    }

    if (reportData.image1 != null) {
      String fileName = reportData.image1!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach1",
          MultipartFile.fromFileSync(
            reportData.image1!.path,
            filename: fileName,
          ),
        ),
      );
    }

    if (reportData.image2 != null) {
      String fileName = reportData.image2!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach2",
          MultipartFile.fromFileSync(
            reportData.image2!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.image3 != null) {
      String fileName = reportData.image3!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach3",
          MultipartFile.fromFileSync(
            reportData.image3!.path,
            filename: fileName,
          ),
        ),
      );
    }

    return await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportSuggestion,
      formData: formData,
    );
  }

  Future<dynamic> addBugIssue({required ReportRequest reportData}) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry("content", reportData.content));

    if (reportData.userId != null) {
      formData.fields.add(MapEntry("client_user_id", reportData.userId!));
    }

    if (reportData.image1 != null) {
      String fileName = reportData.image1!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach1",
          MultipartFile.fromFileSync(
            reportData.image1!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.image2 != null) {
      String fileName = reportData.image2!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach2",
          MultipartFile.fromFileSync(
            reportData.image2!.path,
            filename: fileName,
          ),
        ),
      );
    }
    if (reportData.image3 != null) {
      String fileName = reportData.image3!.path.split('/').last;
      formData.files.add(
        MapEntry(
          "attach3",
          MultipartFile.fromFileSync(
            reportData.image3!.path,
            filename: fileName,
          ),
        ),
      );
    }

    return await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportIssue,
      formData: formData,
    );
  }
}
