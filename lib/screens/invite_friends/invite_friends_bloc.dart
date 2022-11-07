import 'package:client_app/utils/mixins.dart';
import 'package:client_app/models/https/contact_list_upload.dart';
import 'package:client_app/sevices/account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class InviteFriendsBloc extends Bloc<AccountService> {
  bool permissionDenied = true;
  ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier<List<Contact>>([]);

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

    for (var item in contactsNotifier.value) {
      String contactName = item.displayName != "" ? item.displayName : (item.name.first + " " + item.name.last);
      String phoneNumber = item.phones.isNotEmpty ? item.phones[0].number : "";
      String email = item.emails.isNotEmpty ? item.emails[0].address : "";
      listOfContacts.list
          .add(MyContact(full_name: contactName, mobileNumber: phoneNumber, email: email, clientownerid: 0));
    }

    await service.uploadContactList(contacts: listOfContacts);
  }
}
