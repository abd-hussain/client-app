import 'dart:async';
import 'dart:io';
import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageHolder extends StatefulWidget {
  final Function(File image) addImageCallBack;
  final Function() deleteImageCallBack;
  final bool isFromNetwork;
  final String? urlImage;
  final double hight;
  final double width;

  const ImageHolder({
    super.key,
    required this.addImageCallBack,
    required this.deleteImageCallBack,
    this.isFromNetwork = false,
    this.urlImage,
    this.hight = 116,
    this.width = 100,
  });

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  ValueNotifier<File?> imageController = ValueNotifier<File?>(null);
  File? image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheetsUtil().addImageBottomSheet(
          context,
          image?.path.isNotEmpty ?? false || widget.urlImage != null,
          deleteCallBack: () {
            image = null;
            imageController.value = null;
            widget.deleteImageCallBack();
            setState(() {});
            Navigator.pop(context);
          },
          cameraCallBack: () async {
            image = await pickImage(ImageSource.camera);
            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!widget.isFromNetwork) {
              imageController.value = image;
            }
            widget.addImageCallBack(image!);
          },
          galleryCallBack: () async {
            image = await pickImage(ImageSource.gallery);

            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!widget.isFromNetwork) {
              imageController.value = image;
            }
            widget.addImageCallBack(image!);
          },
        );
      },
      child: Container(
        height: widget.hight,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8))),
        child: ValueListenableBuilder<File?>(
          valueListenable: imageController,
          builder: (context, snapshot, child) {
            return snapshot != null || widget.urlImage != null
                ? widget.isFromNetwork
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppConstant.imagesBaseURLForProfileImages + widget.urlImage!,
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
