import 'package:client_app/utils/mixins.dart';

class PostRequest implements Model {
  String content;

  PostRequest({required this.content});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['content'] = content;
    return data;
  }
}
