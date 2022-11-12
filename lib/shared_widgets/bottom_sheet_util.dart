import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/models/gender_model.dart';
import 'package:client_app/models/https/countries_model.dart';
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
                      CustomText(
                        title: AppLocalizations.of(context)!.profilephotosetting,
                        textColor: Colors.black,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 27.0),
                      TextButton(
                        onPressed: () {
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
                      CustomText(
                        title: AppLocalizations.of(context)!.setprofilephoto,
                        textColor: Colors.black,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 27.0),
                      SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                galleryCallBack();
                              },
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CustomText(
                                        title: AppLocalizations.of(context)!.pickimagefromstudio,
                                        fontSize: 16,
                                        textColor: const Color(0xff444444),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                cameraCallBack();
                              },
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Color(0xff444444),
                                        )),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CustomText(
                                        title: AppLocalizations.of(context)!.pickimagefromcamera,
                                        fontSize: 16,
                                        textColor: const Color(0xff444444),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
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

  Future genderBottomSheet(BuildContext context, List<Gender> listOfGender, Function(Gender) selectedGender) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: AppLocalizations.of(context)!.genderprofile,
                  textColor: Colors.black,
                  fontSize: 20,
                ),
                const SizedBox(height: 27.0),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: listOfGender.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          selectedGender(listOfGender[index]);
                        },
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(width: 40, height: 40, child: listOfGender[index].icon),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomText(
                                  title: listOfGender[index].name,
                                  fontSize: 16,
                                  textColor: const Color(0xff444444),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }

  Future countryBottomSheet(BuildContext context, List<Country> listOfCountries, Function(Country) selectedCountry) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.selectCountry,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: listOfCountries.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        selectedCountry(listOfCountries[index]);
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 40,
                                height: 40,
                                child: FadeInImage(
                                    placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
                                    image: NetworkImage(listOfCountries[index].flagImage!, scale: 1))),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomText(
                                title: listOfCountries[index].name!,
                                fontSize: 16,
                                textColor: const Color(0xff444444),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future areYouShoureButtomSheet(
      {required BuildContext context, required String message, required VoidCallback yes, required VoidCallback no}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.areyousure,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 8),
              CustomText(
                title: message,
                textColor: Colors.black,
                fontSize: 18,
              ),
              const SizedBox(height: 27.0),
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    CustomButton(
                        buttonTitle: AppLocalizations.of(context)!.cancel,
                        enableButton: true,
                        width: MediaQuery.of(context).size.width / 4,
                        onTap: () => no()),
                    Expanded(child: Container()),
                    CustomButton(
                        buttonTitle: AppLocalizations.of(context)!.sure,
                        enableButton: true,
                        width: MediaQuery.of(context).size.width / 4,
                        onTap: () => yes()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
