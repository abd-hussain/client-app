import 'package:client_app/utils/mixins.dart';

class UploadContact implements Model {
  List<MyContact> list;

  UploadContact({required this.list});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['list'] = list.map((v) => v.toJson()).toList();
    return data;
  }
}

class MyContact {
  String? full_name;
  String? mobileNumber;
  String? email;
  int? clientownerid;

  MyContact({this.full_name, this.mobileNumber, this.email, this.clientownerid});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['full_name'] = full_name ?? "";
    data['mobile_number'] = mobileNumber ?? "";
    data['email'] = email ?? "";
    data['client_owner_id'] = clientownerid ?? 0;
    return data;
  }
}