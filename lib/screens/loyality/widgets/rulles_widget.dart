import 'package:client_app/models/rules_of_loyality.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RullesWidget extends StatelessWidget {
  final List<LoyalityRules> listOrRules;
  final Function(LoyalityRules) onTap;

  const RullesWidget({
    required this.onTap,
    super.key,
    required this.listOrRules,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(0, 0.1),
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: listOrRules.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  rullChild(
                    context: context,
                    roll: listOrRules[index],
                  ),
                  index != listOrRules.length - 1
                      ? Container(
                          height: 0.5,
                          color: const Color(0xff444444),
                        )
                      : Container()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget rullChild({required BuildContext context, required LoyalityRules roll}) {
    return ListTile(
      title: Row(
        children: [
          const Icon(Icons.task_alt),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 140,
            child: CustomText(
              title: roll.content,
              fontSize: 14,
              textColor: const Color(0xff444444),
              maxLins: 10,
            ),
          ),
          Expanded(child: Container()),
          Column(
            children: [
              CustomText(
                title: roll.numberOfPoint.toString(),
                fontSize: 16,
                textColor: const Color(0xff034061),
                fontWeight: FontWeight.bold,
              ),
              Container(
                width: 10,
                height: 1,
                color: const Color(0xff034061),
              ),
              const SizedBox(height: 1),
              Container(
                width: 6,
                height: 1,
                color: const Color(0xff034061),
              )
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_right),
        ],
      ),
      onTap: () => onTap(roll),
    );
  }
}
