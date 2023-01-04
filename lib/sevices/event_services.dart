import 'package:client_app/models/https/event_Details_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class EventService with Service {
  Future<EventDetails> getEventDetails({required int eventId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.event,
      queryParam: {"id": eventId},
    );
    return EventDetails.fromJson(response);
  }
}
