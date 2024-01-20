import 'package:client_app/utils/mixins.dart';

class UploadContact implements Model {
  List<MyContact>? list;

  UploadContact({required this.list});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyContact {
  String? fullName;
  String? mobileNumber;
  String? email;
  int? clientOwnerId;

  MyContact({this.fullName, this.mobileNumber, this.email, this.clientOwnerId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['full_name'] = fullName;
    data['mobile_number'] = mobileNumber;
    data['email'] = email;
    data['client_owner_id'] = clientOwnerId;
    return data;
  }
}
