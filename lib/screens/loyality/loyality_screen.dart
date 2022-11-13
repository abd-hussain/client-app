import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:flutter/material.dart';

class LoyalityScreen extends StatelessWidget {
  const LoyalityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : LoyalityScreen
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopBarWidget(),
            const SizedBox(height: 20),
            Expanded(child: Container()),
            const Center(
              child: Text("LoyalityScreen"),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
