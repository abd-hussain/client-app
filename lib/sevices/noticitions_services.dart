import 'package:client_app/models/https/notifications_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class NotificationsService with Service {
  Future<NotificationsResponse> listOfNotifications() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.notifications,
    );
    return NotificationsResponse.fromJson(response);
  }

  Future<bool> markAllNotificationsReaded() async {
    await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.notifications,
    );
    return true;
  }

  Future<bool> deleteNotification(int id) async {
    await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.notifications,
      queryParam: {"id": id},
    );
    return true;
  }

  Future<bool> registerToken(String token) async {
    await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.registerTokenNotification,
      queryParam: {"token": token},
    );
    return true;
  }
}
