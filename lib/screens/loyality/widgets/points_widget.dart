import 'package:client_app/models/https/account_info_response.dart';
import 'package:client_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PointsWidget extends StatelessWidget {
  final ValueNotifier<AccountInfo?> pointNotifier;
  const PointsWidget({required this.pointNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 0.1),
            ),
          ],
        ),
        child: Center(
          child: ValueListenableBuilder<AccountInfo?>(
              valueListenable: pointNotifier,
              builder: (context, snapshot, child) {
                if (snapshot != null) {
                  return CustomText(
                    title: snapshot.data!.points.toString(),
                    fontSize: 30,
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                  );
                } else {
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4CB6EA)),
                  );
                }
              }),
        ),
      ),
    );
  }
}
