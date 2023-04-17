import 'package:client_app/models/https/archive.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class ArchiveService with Service {
  Future<Archive> getAllClientArchive() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.archive,
    );
    return Archive.fromJson(response);
  }
}
