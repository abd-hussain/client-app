import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/models/https/update_account_request.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';
import 'package:dio/dio.dart';

class AccountService with Service {
  Future<AccountInfo> getAccountInfo() async {
    final response = await repository.callRequest(
        requestType: RequestType.get, methodName: MethodNameConstant.account);
    return AccountInfo.fromJson(response);
  }

  Future<AccountInfo> updateAccount(
      {required UpdateAccountRequest account}) async {
    FormData formData = FormData();
    if (account.gender != null) {
      formData.fields.add(MapEntry("gender", account.gender.toString()));
    }
    if (account.countryId != null) {
      formData.fields.add(MapEntry("country_id", account.countryId.toString()));
    }
    if (account.referalCode != null) {
      formData.fields.add(MapEntry("referal_code", account.referalCode!));
    }
    if (account.firstName != null) {
      formData.fields.add(MapEntry("first_name", account.firstName!));
    }
    if (account.lastName != null) {
      formData.fields.add(MapEntry("last_name", account.lastName!));
    }
    if (account.email != null) {
      formData.fields.add(MapEntry("email", account.email!));
    }
    if (account.dateOfBirth != null) {
      formData.fields.add(MapEntry("date_of_birth", account.dateOfBirth!));
    }

    if (account.profileImage != null) {
      formData.files.add(
        MapEntry(
          "profile_picture",
          MultipartFile.fromFileSync(
            account.profileImage!.path,
            filename: account.profileImage!.path.split('/').last,
          ),
        ),
      );
    }

    final response = await repository.callRequest(
        requestType: RequestType.put,
        methodName: MethodNameConstant.updateAccount,
        formData: formData);

    return AccountInfo.fromJson(response);
  }

  Future<dynamic> removeAccount() async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }
}
