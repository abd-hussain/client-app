import 'dart:async';
import 'dart:io';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageHolder extends StatelessWidget {
  final Function(File image) addImageCallBack;
  final Function() deleteImageCallBack;
  final bool isFromNetwork;
  final String? urlImage;

  const ImageHolder({
    super.key,
    required this.addImageCallBack,
    required this.deleteImageCallBack,
    this.isFromNetwork = false,
    this.urlImage,
  });

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> imageController = ValueNotifier<File?>(null);
    File? image;
    return InkWell(
      onTap: () {
        BottomSheetsUtil().addImageBottomSheet(
          context,
          image?.path.isNotEmpty ?? false || urlImage != null,
          deleteCallBack: () {
            deleteImageCallBack();
            // if (!isFromNetwork) {
            image = null;

            imageController.value = image;

            // }
            Navigator.pop(context);
          },
          cameraCallBack: () async {
            image = await pickImage(ImageSource.camera);
            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!isFromNetwork) {
              imageController.value = image;
            }
            addImageCallBack(image!);
          },
          galleryCallBack: () async {
            image = await pickImage(ImageSource.gallery);
            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!isFromNetwork) {
              imageController.value = image;
            }
            addImageCallBack(image!);
          },
        );
      },
      child: Container(
        height: 116,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8))),
        child: ValueListenableBuilder<File?>(
          valueListenable: imageController,
          builder: (context, snapshot, child) {
            return snapshot != null || urlImage != null
                ? isFromNetwork
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppConstant.imagesBaseURLForProfileImages + urlImage!,
                          width: 100,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          snapshot!,
                          width: 100,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.picprofile,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        textColor: Colors.black,
                      ),
                      const Icon(
                        Icons.add,
                        color: Color(0xff444444),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
