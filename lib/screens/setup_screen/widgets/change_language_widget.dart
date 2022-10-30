import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class ChangeLanguageWidget extends StatelessWidget {
  final ValueNotifier<int> selectedLanguageNotifier;
  final Function(int) segmentChange;
  const ChangeLanguageWidget({Key? key, required this.selectedLanguageNotifier, required this.segmentChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Center(
        child: ValueListenableBuilder<int>(
            valueListenable: selectedLanguageNotifier,
            builder: (context, data, child) {
              return MaterialSegmentedControl(
                children: const {
                  0: SizedBox(
                    width: 120,
                    child: Center(
                      child: CustomText(
                        title: 'English',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  1: SizedBox(
                    width: 120,
                    child: Center(
                        child: CustomText(
                      title: 'العربية',
                      fontSize: 16,
                    )),
                  ),
                },
                selectionIndex: selectedLanguageNotifier.value,
                selectedColor: const Color(0xff034061),
                unselectedColor: const Color(0xffD9D9D9),
                borderRadius: 4.0,
                horizontalPadding: const EdgeInsets.all(20.0),
                verticalOffset: 8.0,
                onSegmentChosen: (index) async {
                  segmentChange(index as int);
                },
              );
            }),
      ),
    );
  }
}
