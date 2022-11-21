import 'dart:typed_data';

import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ListOfContactsWidget extends StatefulWidget {
  final List<Contact> contacts;
  const ListOfContactsWidget({Key? key, required this.contacts}) : super(key: key);

  @override
  State<ListOfContactsWidget> createState() => _ListOfContactsWidgetState();
}

class _ListOfContactsWidgetState extends State<ListOfContactsWidget> {
  List<bool> listOfCheckboxInContact = [];

  @override
  void initState() {
    listOfCheckboxInContact = List<bool>.generate(widget.contacts.length, (i) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  Uint8List? image = widget.contacts[index].photo;
                  String num =
                      (widget.contacts[index].phones.isNotEmpty) ? (widget.contacts[index].phones.first.number) : "--";
                  return ListTile(
                      leading: (widget.contacts[index].photo == null)
                          ? const CircleAvatar(child: Icon(Icons.person))
                          : CircleAvatar(backgroundImage: MemoryImage(image!)),
                      title: Text("${widget.contacts[index].name.first} ${widget.contacts[index].name.last}"),
                      subtitle: Text(num),
                      trailing: Checkbox(
                        value: listOfCheckboxInContact[index],
                        onChanged: (value) {
                          listOfCheckboxInContact[index] = !listOfCheckboxInContact[index];
                          setState(() {});
                        },
                      ),
                      onTap: null);
                }),
          ),
          CustomButton(
            buttonTitle: "Send",
            enableButton: listOfCheckboxInContact.contains(true) ? true : false,
            onTap: () async {
              //TODO : this not working yet
              if (await canSendSMS()) {
                String message = "This is a test message!";
                List<String> recipents = ["1234567890", "5556787676"];
                await sendSMS(message: message, recipients: recipents, sendDirect: false);
              }
            },
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
