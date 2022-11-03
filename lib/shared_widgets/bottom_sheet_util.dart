import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetsUtil {
  Future addImageBottomSheet(BuildContext context, bool? image,
      {required VoidCallback galleryCallBack,
      required VoidCallback cameraCallBack,
      required VoidCallback deleteCallBack}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: image!
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          deleteCallBack();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.hide_image,
                              color: Color(0xff4CB6EA),
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              title: AppLocalizations.of(context)!.pickimageremoveimage,
                              textColor: Colors.red,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          galleryCallBack();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              color: Color(0xff4CB6EA),
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              title: AppLocalizations.of(context)!.pickimagefromstudio,
                              textColor: const Color(0xff444444),
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: const Color(0xff4CB6EA),
                        height: 1,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          cameraCallBack();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xff4CB6EA),
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              title: AppLocalizations.of(context)!.pickimagefromcamera,
                              textColor: const Color(0xff444444),
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
          );
        });
  }
}
