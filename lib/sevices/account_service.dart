import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class AccountService with Service {
  Future<AccountInfo> getAccountInfo() async {
    final response = await repository.callRequest(requestType: RequestType.get, methodName: MethodNameConstant.account);
    return AccountInfo.fromJson(response);
  }

  Future<AccountInfo> updateAccount({required UpdateAccountRequest account}) async {
    Map<String, dynamic> updateMap = {};

    if (account.gender != null) {
      updateMap["gender"] = MultipartFile.fromString(account.gender.toString());
    }

    if (account.countryId != null) {
      updateMap["country_id"] = MultipartFile.fromString(account.countryId.toString());
    }

    if (account.referalCode != null) {
      updateMap["referal_code"] = MultipartFile.fromString(account.referalCode!);
    }

    if (account.firstName != null) {
      updateMap["first_name"] = MultipartFile.fromString(account.firstName!);
    }

    if (account.lastName != null) {
      updateMap["last_name"] = MultipartFile.fromString(account.lastName!);
    }

    if (account.email != null) {
      updateMap["email"] = MultipartFile.fromString(account.email!);
    }

    if (account.dateOfBirth != null) {
      updateMap["date_of_birth"] = MultipartFile.fromString(account.dateOfBirth!);
    }

    if (account.profileImage != null) {
      String fileName = account.profileImage!.path.split('/').last;
      print("+++++++ fileName   ${fileName}");
      print("+++++++ filePath  ${account.profileImage!.path}");

      updateMap["profile_picture"] = MultipartFile.fromFile(account.profileImage!.path, filename: fileName);
    }

    FormData formData = FormData.fromMap(updateMap);

    // final response = await repository.callRequest(
    //     requestType: RequestType.put, methodName: MethodNameConstant.updateAccount, formData: formData);

    return AccountInfo.fromJson({});
  }

  Future<dynamic> removeAccount() async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }
}
