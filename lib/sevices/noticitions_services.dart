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
}
