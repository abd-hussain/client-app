import 'package:client_app/shared_widgets/bottom_sheet_util.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ReportAttatchment extends StatelessWidget {
  const ReportAttatchment({Key? key}) : super(key: key);

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> image1Controller = ValueNotifier<File?>(null);
    ValueNotifier<File?> image2Controller = ValueNotifier<File?>(null);
    ValueNotifier<File?> image3Controller = ValueNotifier<File?>(null);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  false,
                  deleteCallBack: () {
                    image1Controller.value = null;
                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    File image = await pickImage(ImageSource.camera);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image1Controller.value = image;
                  },
                  galleryCallBack: () async {
                    File image = await pickImage(ImageSource.gallery);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image1Controller.value = image;
                  },
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/attach_placeholder.png",
                    width: 70,
                    height: 70,
                  ),
                  ValueListenableBuilder<File?>(
                      valueListenable: image1Controller,
                      builder: (context, snapshot, child) {
                        return snapshot != null
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    snapshot,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  false,
                  deleteCallBack: () {
                    image2Controller.value = null;
                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    File image = await pickImage(ImageSource.camera);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image2Controller.value = image;
                  },
                  galleryCallBack: () async {
                    File image = await pickImage(ImageSource.gallery);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image2Controller.value = image;
                  },
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/attach_placeholder.png",
                    width: 70,
                    height: 70,
                  ),
                  ValueListenableBuilder<File?>(
                      valueListenable: image2Controller,
                      builder: (context, snapshot, child) {
                        return snapshot != null
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    snapshot,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BottomSheetsUtil().addImageBottomSheet(
                context,
                false,
                deleteCallBack: () {
                  image3Controller.value = null;
                  Navigator.pop(context);
                },
                cameraCallBack: () async {
                  File image = await pickImage(ImageSource.camera);
                  if (image.path.isEmpty) {
                    return;
                  }
                  image3Controller.value = image;
                },
                galleryCallBack: () async {
                  File image = await pickImage(ImageSource.gallery);
                  if (image.path.isEmpty) {
                    return;
                  }
                  image3Controller.value = image;
                },
              );
            },
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/attach_placeholder.png",
                  width: 70,
                  height: 70,
                ),
                ValueListenableBuilder<File?>(
                    valueListenable: image3Controller,
                    builder: (context, snapshot, child) {
                      return snapshot != null
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  snapshot,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container();
                    }),
              ],
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
