import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ItemInGrid extends StatelessWidget {
  final String title;
  final String? value;
  final double valueHight;

  const ItemInGrid({
    super.key,
    required this.title,
    required this.value,
    this.valueHight = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          color: Colors.grey[300],
          child: Center(
            child: CustomText(
              title: title,
              fontSize: 16,
              textColor: Colors.black,
            ),
          ),
        ),
        Container(
          height: valueHight,
          color: Colors.grey[400],
          child: Center(
            child: value != null
                ? CustomText(
                    title: value!,
                    fontSize: 16,
                    textColor: Colors.black,
                  )
                : const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      color: Color(0xff034061),
                      strokeWidth: 3,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
