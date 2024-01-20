import 'package:client_app/locator.dart';
import 'package:client_app/models/https/contact_list_upload.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:client_app/sevices/settings_service.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InviteFriendsBloc extends Bloc<SettingService> {
  ValueNotifier<String> invitationCodeNotifier = ValueNotifier<String>("");

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future fetchContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      uploadContactsListToServer(await FlutterContacts.getContacts(withProperties: true, withPhoto: true));
    }
  }

  Future<void> uploadContactsListToServer(List<Contact> contatctList) async {
    var listOfContacts = UploadContact(list: []);

    for (var item in contatctList) {
      String contactName = item.displayName != "" ? item.displayName : ("${item.name.first} ${item.name.last}");
      String phoneNumber = item.phones.isNotEmpty ? item.phones[0].number : "";
      String email = item.emails.isNotEmpty ? item.emails[0].address : "";

      var obj = MyContact(
        fullName: contactName,
        mobileNumber: phoneNumber.replaceAll(" ", ""),
        email: email,
      );

      if (box.get(DatabaseFieldConstant.userid) != null) {
        obj.clientOwnerId = box.get(DatabaseFieldConstant.userid);
      }

      listOfContacts.list!.add(obj);
    }

    if (listOfContacts.list!.isNotEmpty) {
      await service.uploadContactList(contacts: listOfContacts);
    }
  }

  bool checkIfUserIsLoggedIn() {
    bool isItLoggedIn = false;

    if (box.get(DatabaseFieldConstant.isUserLoggedIn) != null) {
      isItLoggedIn = box.get(DatabaseFieldConstant.isUserLoggedIn);
    }

    return isItLoggedIn;
  }

  void getProfileInformations() async {
    locator<AccountService>().getAccountInfo().then((value) {
      final data = value.data;
      //TODO : Test Again
      if (data != null) {
        invitationCodeNotifier.value = data.invitationCode ?? "";
      }
    });
  }

  @override
  onDispose() {
    invitationCodeNotifier.dispose();
  }
}
