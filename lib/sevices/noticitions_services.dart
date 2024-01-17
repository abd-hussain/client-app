import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class NotificationsService with Service {
  Future<NotificationsResponse> listOfNotifications() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.notifications,
      queryParam: {"userType": "client"},
    );
    return NotificationsResponse.fromJson(response);
  }

  Future<bool> registerToken(String token) async {
    await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.registerTokenNotification,
      queryParam: {"token": token, "userType": "client"},
    );
    return true;
  }
}
