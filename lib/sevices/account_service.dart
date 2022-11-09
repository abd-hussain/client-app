import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/contact_list_upload.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class AccountService with Service {
  Future<AccountInfo> getAccountInfo() async {
    final response = await repository.callRequest(requestType: RequestType.get, methodName: MethodNameConstant.account);
    return AccountInfo.fromJson(response);
  }

  Future<AccountInfo> updateAccount({required UpdateAccountRequest account}) async {
    FormData? formData;
    if (account.profileImage != null) {
      String fileName = account.profileImage!.path.split('/').last;

      formData = FormData.fromMap({
        "profile_picture": await MultipartFile.fromFile(account.profileImage!.path, filename: fileName),
        "first_name": MultipartFile.fromString(account.firstName!),
        "last_name": MultipartFile.fromString(account.lastName!),
        "email": MultipartFile.fromString(account.email!),
        "referal_code": MultipartFile.fromString(account.referalCode!),
        "date_of_birth": MultipartFile.fromString(account.dateOfBirth!),
        "country_id": MultipartFile.fromString(account.countryId!.toString()),
        "gender": MultipartFile.fromString(account.gender!.toString()),
      });
    } else {
      formData = FormData.fromMap({
        "first_name": MultipartFile.fromString(account.firstName!),
        "last_name": MultipartFile.fromString(account.lastName!),
        "email": MultipartFile.fromString(account.email!),
        "referal_code": MultipartFile.fromString(account.referalCode!),
        "date_of_birth": MultipartFile.fromString(account.dateOfBirth!),
        "country_id": MultipartFile.fromString(account.countryId!.toString()),
        "gender": MultipartFile.fromString(account.gender!.toString()),
      });
    }

    final response = await repository.callRequest(
        requestType: RequestType.multiPartPut, methodName: MethodNameConstant.updateAccount, formData: formData);
    return AccountInfo.fromJson(response);
  }

  Future<void> uploadContactList({required UploadContact contacts}) async {
    // TODO Test This API After Prepare it from Backend side
    await repository.callRequest(
        requestType: RequestType.post, methodName: MethodNameConstant.uploadContactList, postBody: contacts);
  }
}
