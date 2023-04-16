import 'package:client_app/utils/mixins.dart';

class LoyalityPointRequest implements Model {
  String title;
  int point;

  LoyalityPointRequest({
    required this.title,
    required this.point,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['request_title'] = title;
    data['number_of_point_requested'] = point;
    return data;
  }
}
