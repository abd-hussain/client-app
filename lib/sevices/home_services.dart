import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class HomeService with Service {
  Future<HomeResponse> getHome() async {
    print("getHome");
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.home,
    );
    print("response");

    return HomeResponse.fromJson(response);
  }
}
