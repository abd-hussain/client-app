import 'package:client_app/models/https/posts_response.dart';
import 'package:client_app/sevices/post_services.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditPostBloc extends Bloc<PostService> {
  TextEditingController textController = TextEditingController();
  ValueNotifier<bool> enableSubmitBtn = ValueNotifier<bool>(false);
  String pageTitle = "";
  int postId = 0;

  void handleReadingArguments({required BuildContext context, required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      pageTitle = AppLocalizations.of(context)!.editpost;
      postId = (newArguments["postId"] as int?) ?? 0;
      textController.text = newArguments["content"] as String;
    } else {
      pageTitle = AppLocalizations.of(context)!.addpost;
    }
  }

  void validationFields() {
    enableSubmitBtn.value = false;

    if (textController.text.isNotEmpty) {
      enableSubmitBtn.value = true;
    }
  }

  Future<PostsResponse> callAddEditPostRequest() async {
    if (postId == 0) {
      return await service.addPost(content: textController.text);
    } else {
      return await service.editPost(content: textController.text, postId: postId);
    }
  }
}
