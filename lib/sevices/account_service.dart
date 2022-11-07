import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/contact_list_upload.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class AccountService with Service {
  Future<AccountInfo> getAccountInfo() async {
    final response = await repository.callRequest(requestType: RequestType.get, methodName: MethodNameConstant.account);
    return AccountInfo.fromJson(response);
  }

  Future<AccountInfo> updateAccount({required UpdateAccountRequest account}) async {
    final response = await repository.callRequest(
        requestType: RequestType.put, methodName: MethodNameConstant.updateAccount, postBody: account);
    return AccountInfo.fromJson(response);
  }

  Future<void> uploadContactList({required UploadContact contacts}) async {
    // TODO Test This API After Prepare it from Backend side
    await repository.callRequest(
        requestType: RequestType.post, methodName: MethodNameConstant.uploadContactList, postBody: contacts);
  }
}
