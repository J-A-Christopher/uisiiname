import 'package:flutter/material.dart';
import 'package:usiiname/components/intro_screen_component.dart';
import 'package:usiiname/components/test_slides.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
              child:
                  //IntroSLides()
                  OnBoardingScreen())
        ],
      ),
    );
  }
}
