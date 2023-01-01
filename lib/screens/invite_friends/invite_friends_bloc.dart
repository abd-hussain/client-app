import 'package:client_app/sevices/settings_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/contact_list_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InviteFriendsBloc extends Bloc<SettingService> {
  bool permissionDenied = true;
  ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier<List<Contact>>([]);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contactsNotifier.value = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      permissionDenied = false;
      uploadContactsListToServer();
    } else {
      contactsNotifier.value = [];
      permissionDenied = true;
    }
  }

  Future<void> uploadContactsListToServer() async {
    var listOfContacts = UploadContact(list: []);

    String usedId = box.get(DatabaseFieldConstant.userid);

    for (var item in contactsNotifier.value) {
      String contactName = item.displayName != "" ? item.displayName : ("${item.name.first} ${item.name.last}");
      String phoneNumber = item.phones.isNotEmpty ? item.phones[0].number : "";
      String email = item.emails.isNotEmpty ? item.emails[0].address : "";
      listOfContacts.list.add(MyContact(
          fullName: contactName,
          mobileNumber: phoneNumber,
          email: email,
          clientownerid: usedId == "" ? null : int.parse(usedId)));
    }

    await service.uploadContactList(contacts: listOfContacts);
  }

  @override
  onDispose() {
    contactsNotifier.dispose();
  }
}
