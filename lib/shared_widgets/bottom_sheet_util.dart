import 'package:client_app/shared_widgets/custom_button.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:client_app/models/gender_model.dart';
import 'package:client_app/models/https/countries_model.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:client_app/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
                                width: 30,
                                height: 30,
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

  Future areYouShoureButtomSheet({required BuildContext context, required String message, required VoidCallback sure}) {
    return showModalBottomSheet(
      enableDrag: false,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: 175,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomText(
                          title: message,
                          textColor: const Color(0xff191C1F),
                          fontSize: 16,
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 1,
                          color: Color(0xffEBEBEB),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Navigator.pop(context);
                                sure();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: CustomText(
                                  title: AppLocalizations.of(context)!.sure,
                                  textColor: const Color(0xffE74C4C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 50,
                          width: double.infinity,
                          child: CustomText(
                            title: AppLocalizations.of(context)!.cancel,
                            textColor: const Color(0xff1A59B9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future showStoryFullView(
      {required BuildContext context,
      required String assets,
      required String profileName,
      required String profileImg,
      required int profileId,
      required Function(int) openProfile,
      required Function(int) reportStory}) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: false,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 50),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => openProfile(profileId),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff034061),
                      radius: 30,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(profileImg),
                      ),
                    ),
                  ),
                  CustomText(
                    title: profileName,
                    textColor: Colors.black,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                    child: Image.network(AppConstant.imagesBaseURLForStories + assets),
                  ),
                  const SizedBox(height: 5),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      reportStory(profileId);
                    },
                    icon: const Icon(
                      Icons.report,
                      color: Color(0xff444444),
                    ),
                  )
                ],
              ));
        });
  }

  Future bookMeetingBottomSheet1(
      {required BuildContext context, required double hourRate, required Function() openNext}) {
    ValueNotifier<bool> selectedMeetingType = ValueNotifier<bool>(true);
    ValueNotifier<double?> selectedMeetingDuration = ValueNotifier<double?>(null);

    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: false,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Center(
                  child: CustomText(
                    title: AppLocalizations.of(context)!.booknow,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Center(
                  child: CustomText(
                    title: "1 / 3",
                    textColor: Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingtype,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                    valueListenable: selectedMeetingType,
                    builder: (context, snapshot, child) {
                      return Column(
                        children: [
                          customItemForSelection(
                            context: context,
                            title: AppLocalizations.of(context)!.bookingonetime,
                            isSelected: snapshot,
                            onPress: () {
                              selectedMeetingType.value = true;
                            },
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 8),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingduration,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<double?>(
                    valueListenable: selectedMeetingDuration,
                    builder: (context, snapshot, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customItemForSelection(
                            context: context,
                            title: "15 ${AppLocalizations.of(context)!.min}",
                            isSelected: (snapshot ?? 0) == 15,
                            onPress: () {
                              selectedMeetingDuration.value = 15;
                            },
                          ),
                          customItemForSelection(
                            context: context,
                            title: "30 ${AppLocalizations.of(context)!.min}",
                            isSelected: (snapshot ?? 0) == 30,
                            onPress: () {
                              selectedMeetingDuration.value = 30;
                            },
                          ),
                          customItemForSelection(
                            context: context,
                            title: "45 ${AppLocalizations.of(context)!.min}",
                            isSelected: (snapshot ?? 0) == 45,
                            onPress: () {
                              selectedMeetingDuration.value = 45;
                            },
                          ),
                          customItemForSelection(
                            context: context,
                            title: "60 ${AppLocalizations.of(context)!.min}",
                            isSelected: (snapshot ?? 0) == 60,
                            onPress: () {
                              selectedMeetingDuration.value = 60;
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),
                Container(height: 1, color: const Color(0xff444444)),
                ValueListenableBuilder<double?>(
                    valueListenable: selectedMeetingDuration,
                    builder: (context, selectedMeetingDurationSnapshot, child) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                CustomText(
                                  title: selectedMeetingDurationSnapshot == null
                                      ? "00 JD"
                                      : Currency().getCorrectAmountAndCurrency(
                                          selectedMeetingDurationSnapshot == 60 ? hourRate : hourRate / 2), // TODO
                                  textColor: const Color(0xff444444),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                CustomText(
                                  title: selectedMeetingDurationSnapshot == null
                                      ? "00 ${AppLocalizations.of(context)!.min}"
                                      : "$selectedMeetingDurationSnapshot ${AppLocalizations.of(context)!.min}",
                                  textColor: const Color(0xff444444),
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              enableButton: selectedMeetingDurationSnapshot == null ? false : true,
                              buttonTitle: AppLocalizations.of(context)!.next,
                              onTap: () {
                                Navigator.pop(context);
                                openNext();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          );
        });
  }

  Widget customItemForSelection(
      {required BuildContext context, required String title, required bool isSelected, required Function() onPress}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onPress(),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? const Color(0xff034061) : const Color(0xffE4E9EF)),
            color: const Color(0xffE4E9EF),
          ),
          child: Center(
            child: CustomText(
              title: title,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future bookMeetingBottomSheet2({required BuildContext context, required Function() openNext}) {
    ValueNotifier<double?> selectedMeetingDuration = ValueNotifier<double?>(null);

    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: false,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Center(
                  child: CustomText(
                    title: AppLocalizations.of(context)!.booknow,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Center(
                  child: CustomText(
                    title: "2 / 3",
                    textColor: Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingtype,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                SfCalendar(
                  view: CalendarView.month,
                  firstDayOfWeek: 6,
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                    numberOfWeeksInView: 6,
                    appointmentDisplayCount: 10,
                  ),
                  onTap: (calendarTapDetails) {
                    // if (calendarTapDetails.appointments != null &&
                    //     calendarTapDetails.targetElement == CalendarElement.appointment) {
                    //   //TODO handle Clicke
                    //   print(calendarTapDetails.appointments![0].eventName);
                    // }
                  },
                ),
                const SizedBox(height: 8),
                CustomText(
                  title: AppLocalizations.of(context)!.meetingduration,
                  textColor: const Color(0xff444444),
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<double?>(
                    valueListenable: selectedMeetingDuration,
                    builder: (context, snapshot, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "9:00 a.m",
                                  isSelected: (snapshot ?? 0) == 9,
                                  onPress: () {
                                    selectedMeetingDuration.value = 9;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "10:00 a.m",
                                  isSelected: (snapshot ?? 0) == 10,
                                  onPress: () {
                                    selectedMeetingDuration.value = 10;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "11:00 a.m",
                                  isSelected: (snapshot ?? 0) == 11,
                                  onPress: () {
                                    selectedMeetingDuration.value = 11;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "12:00 a.m",
                                  isSelected: (snapshot ?? 0) == 12,
                                  onPress: () {
                                    selectedMeetingDuration.value = 12;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "1:00 p.m",
                                  isSelected: (snapshot ?? 0) == 13,
                                  onPress: () {
                                    selectedMeetingDuration.value = 13;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "2:00 p.m",
                                  isSelected: (snapshot ?? 0) == 14,
                                  onPress: () {
                                    selectedMeetingDuration.value = 14;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "3:00 p.m",
                                  isSelected: (snapshot ?? 0) == 15,
                                  onPress: () {
                                    selectedMeetingDuration.value = 15;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "4:00 p.m",
                                  isSelected: (snapshot ?? 0) == 16,
                                  onPress: () {
                                    selectedMeetingDuration.value = 16;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "5:00 p.m",
                                  isSelected: (snapshot ?? 0) == 17,
                                  onPress: () {
                                    selectedMeetingDuration.value = 17;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "6:00 p.m",
                                  isSelected: (snapshot ?? 0) == 18,
                                  onPress: () {
                                    selectedMeetingDuration.value = 18;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "7:00 p.m",
                                  isSelected: (snapshot ?? 0) == 19,
                                  onPress: () {
                                    selectedMeetingDuration.value = 19;
                                  },
                                ),
                              ),
                              Expanded(
                                child: customItemForSelection(
                                  context: context,
                                  title: "8:00 p.m",
                                  isSelected: (snapshot ?? 0) == 20,
                                  onPress: () {
                                    selectedMeetingDuration.value = 20;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),
                Container(height: 1, color: const Color(0xff444444)),
                ValueListenableBuilder<double?>(
                    valueListenable: selectedMeetingDuration,
                    builder: (context, selectedMeetingDurationSnapshot, child) {
                      return Row(
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: CustomButton(
                              enableButton: selectedMeetingDurationSnapshot == null ? false : true,
                              buttonTitle: AppLocalizations.of(context)!.next,
                              onTap: () {
                                Navigator.pop(context);
                                openNext();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          );
        });
  }
}
