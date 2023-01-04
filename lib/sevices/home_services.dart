import 'package:client_app/models/https/home_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

class HomeService with Service {
  Future<HomeResponse> getHome() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.home,
    );
    return HomeResponse.fromJson(response);
  }

  Future<StoryRespose> reportStory({required int storyId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportStory,
      queryParam: {"storyId": storyId},
    );
    return StoryRespose.fromJson(response);
  }

  Future<EventRespose> reportEvent({required int eventId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.reportEvent,
      queryParam: {"eventId": eventId},
    );
    return EventRespose.fromJson(response);
  }
}
