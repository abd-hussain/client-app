import 'package:client_app/screens/login/widget/top_bar.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : EditProfileScreen
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopBarWidget(),
            const SizedBox(height: 20),
            Expanded(child: Container()),
            const Center(
              child: Text("EditProfileScreen"),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
