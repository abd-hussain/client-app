import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/models/https/contact_list_upload.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class AccountService with Service {
  Future<void> uploadContactList({required UploadContact contacts}) async {
    // TODO Test This API After Prepare it from Backend side
    // await repository.callRequest(
    //   requestType: RequestType.post,
    //   methodName: MethodNameConstant.uploadContactList,
    // );
  }
}
