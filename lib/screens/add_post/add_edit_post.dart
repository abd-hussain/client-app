import 'package:client_app/screens/add_post/add_edit_post_bloc.dart';
import 'package:client_app/shared_widgets/custom_appbar.dart';
import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditPostScreen extends StatefulWidget {
  const AddEditPostScreen({super.key});

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  final bloc = AddEditPostBloc();

  @override
  void initState() {
    bloc.textController.addListener(() {
      bloc.validationFields();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.handleReadingArguments(context: context, arguments: ModalRoute.of(context)!.settings.arguments);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: customAppBar(title: bloc.pageTitle),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: bloc.textController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.whatisinyourmind,
                        hintMaxLines: 2,
                        hintStyle: const TextStyle(fontSize: 15),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: 10,
                      maxLength: 150,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: bloc.enableSubmitBtn,
                  builder: (context, snapshot, child) {
                    return CustomButton(
                      enableButton: snapshot,
                      onTap: () => bloc.callAddEditPostRequest().then((value) {
                        Navigator.of(context).pop();
                      }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
