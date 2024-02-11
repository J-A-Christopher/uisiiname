import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usiiname/components/donation_request.dart';
import 'package:usiiname/features/loginfeature/presentation/bloc/login_bloc.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/firebase_options.dart';
import 'package:usiiname/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/utils/fcm_manager.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   //todo: store incoming messages
//   print("Handling a background message: ${message.messageId}");
// }

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FCMManager().initNotifications();
  runApp(const Usiiname());
}

class Usiiname extends StatelessWidget {
  const Usiiname({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/donation-requests': (context) => const DonationRequests()},
      navigatorKey: navigatorKey,
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xfff0f4f3),
          primaryContainer: Color(0xffd0e4ff),
          secondary: Color(0xff8fe1d7),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xffc4c4c4),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        subThemesData: const FlexSubThemesData(
          interactionEffects: false,
          tintedDisabledControls: false,
          blendOnColors: false,
          useTextTheme: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
          alignedDropdown: true,
          tooltipRadius: 4,
          tooltipSchemeColor: SchemeColor.inverseSurface,
          tooltipOpacity: 0.9,
          useInputDecoratorThemeInDialogs: true,
          snackBarElevation: 6,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationBarIndicatorOpacity: 1.00,
          navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationRailIndicatorOpacity: 1.00,
          navigationRailBackgroundSchemeColor: SchemeColor.surface,
          navigationRailLabelType: NavigationRailLabelType.none,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
          keepPrimary: true,
          keepSecondary: true,
          keepTertiary: true,
        ),
        tones: FlexTones.jolly(Brightness.light),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //useMaterial3: true,
        //swapLegacyOnMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SignUpBloc(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
