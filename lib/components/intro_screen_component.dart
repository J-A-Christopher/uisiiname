import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:usiiname/components/login_component.dart';
import 'package:usiiname/components/user_first_route_component.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/utils/storage_utils.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: IntroductionScreen(
        dotsDecorator: DotsDecorator(
          activeColor: Theme.of(context).primaryColor,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
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
        onDone: () async {
          final userToken = await StorageUtils().getUserInfo(key: 'token');
          if (userToken == null) {
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: SignUpBloc(),
                    child: const LoginComponentWrapper(),
                  ),
                ),
              );
            }
            return;
          }
          bool hasExpired = JwtDecoder.isExpired(userToken);
          if (hasExpired) {
            await StorageUtils().logoutUser();
          }
          if (context.mounted) {
            hasExpired
                ? Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: SignUpBloc(),
                        child: const LoginComponentWrapper(),
                      ),
                    ),
                  )
                : Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: SignUpBloc(),
                        child: const UserFirstRoute(),
                      ),
                    ),
                  );
          }
        },
        done: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        showSkipButton: true,
        showNextButton: true,
        skip: const Text(
          "Skip",
        ),
        next: const Icon(
          Icons.arrow_forward,
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
