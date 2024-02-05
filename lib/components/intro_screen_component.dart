import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:usiiname/components/login_component.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: IntroductionScreen(
        pages: [
          PageViewModel(
              title: '',
              body:
                  'You have two hands\n one to help yourself, \n the second to help others.',
              image: buildImage('assets/start01.png', context),
              decoration: getPageDecoration()),
          PageViewModel(
              title: '',
              body:
                  'If you can\'t feed a hundred people,\n then just feed one.',
              image: buildImage('assets/start02.png', context),
              decoration: getPageDecoration()),
          PageViewModel(
              title: '',
              body:
                  'Giving is not just about\n making a donation, it is about\n making a difference.',
              image: buildImage('assets/start03.png', context),
              decoration: getPageDecoration()),
          PageViewModel(
              title: '',
              body: 'Be the change you want to\n see in this world.',
              image: buildImage('assets/start04.png', context),
              decoration: getPageDecoration())
        ],
        onDone: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginComponent()));
        },
        done: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        showSkipButton: true,
        showNextButton: true,
        skip: const Text(
          "Skip",
          style: TextStyle(color: Colors.black),
        ),
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    ));
  }

  Widget buildImage(String path, BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Image.asset(
      path,
      width: mediaQuery.width * 1,
    );
  }

  PageDecoration getPageDecoration() => const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28),
      bodyTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      imagePadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      bodyPadding: EdgeInsets.only(top: 50));
}
