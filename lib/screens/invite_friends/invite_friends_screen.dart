import 'package:client_app/screens/invite_friends/invite_friends_bloc.dart';
import 'package:client_app/screens/invite_friends/widgets/list_of_contacts_widget.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/shared_widgets/shimmers/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final _bloc = InviteFriendsBloc();

//TODO handle Send MEssage
  @override
  void initState() {
    super.initState();
    _bloc.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.invite_friends),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<Contact>>(
              valueListenable: _bloc.contactsNotifier,
              builder: (context, snapshot, child) {
                if (_bloc.permissionDenied) {
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: CustomText(
                          title: AppLocalizations.of(context)!.permision_denied,
                          fontSize: 20,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  );
                } else {
                  return snapshot != []
                      ? ListOfContactsWidget(
                          contacts: snapshot,
                        )
                      : const ShimmerListView(
                          count: 15,
                        );
                }
              }),
        ],
      ),
    );
  }
}
