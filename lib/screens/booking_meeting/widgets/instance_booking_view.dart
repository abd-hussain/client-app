import 'package:client_app/models/https/mentor_info_avaliable_model.dart';
import 'package:client_app/screens/booking_meeting/widgets/sub_widgets/mentor_profile_info.dart';
import 'package:client_app/screens/booking_meeting/widgets/sub_widgets/serching_for_mentor.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstanceBookingView extends StatefulWidget {
  final String? categoryName;
  final ValueNotifier<List<MentorInfoAvaliableResponseData>?> avaliableMentors;
  final Function(MentorInfoAvaliableResponseData) onSelectMentor;

  const InstanceBookingView({
    super.key,
    required this.avaliableMentors,
    required this.categoryName,
    required this.onSelectMentor,
  });

  @override
  State<InstanceBookingView> createState() => _InstanceBookingViewState();
}

class _InstanceBookingViewState extends State<InstanceBookingView> {
  int selectedMentorIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomText(
              title: "-- ${AppLocalizations.of(context)!.selectmentor} --",
              fontSize: 16,
              textColor: const Color(0xff554d56),
            ),
          ),
          ValueListenableBuilder<List<MentorInfoAvaliableResponseData>?>(
              valueListenable: widget.avaliableMentors,
              builder: (context, snapshot, child) {
                if (snapshot == null) {
                  return const SearchForMentorView();
                } else {
                  // Future.delayed(const Duration(milliseconds: 100), () {
                  //   widget.onSelectMentor(snapshot[0]);
                  // });

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 190,
                      child: ListView.builder(
                          itemCount: snapshot.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: FoundedMentorInfoView(
                                data: snapshot[index],
                                selected: selectedMentorIndex == index,
                                onPress: () {
                                  selectedMentorIndex = index;
                                  widget.onSelectMentor(snapshot[index]);
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
