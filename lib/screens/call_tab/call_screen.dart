import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderHomePage(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
