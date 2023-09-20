import 'package:chat_gpt/screen/OnBoarding/on_boarding_screen.dart';
import 'package:chat_gpt/shared/components/navigator.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigateAndFinish(context, const OnBoardingScreen());
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
    );
  }
}
