import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/firebase_options.dart';
import 'package:usiiname/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const Usiiname());
}

class Usiiname extends StatelessWidget {
  const Usiiname({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      // darkTheme: FlexThemeData.dark(
      //   colors: const FlexSchemeColor(
      //     primary: Color(0xfff0f4f3),
      //     primaryContainer: Color(0xff00325b),
      //     secondary: Color(0xff8fe1d7),
      //     secondaryContainer: Color(0xff872100),
      //     tertiary: Color(0xffc4c4c4),
      //     tertiaryContainer: Color(0xff004e59),
      //     appBarColor: Color(0xff872100),
      //     error: Color(0xffcf6679),
      //   ),
      //   subThemesData: const FlexSubThemesData(
      //     interactionEffects: false,
      //     tintedDisabledControls: false,
      //     useTextTheme: true,
      //     inputDecoratorBorderType: FlexInputBorderType.underline,
      //     inputDecoratorUnfocusedBorderIsColored: false,
      //     alignedDropdown: true,
      //     tooltipRadius: 4,
      //     tooltipSchemeColor: SchemeColor.inverseSurface,
      //     tooltipOpacity: 0.9,
      //     useInputDecoratorThemeInDialogs: true,
      //     snackBarElevation: 6,
      //     snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      //     navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      //     navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      //     navigationBarMutedUnselectedLabel: false,
      //     navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      //     navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      //     navigationBarMutedUnselectedIcon: false,
      //     navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      //     navigationBarIndicatorOpacity: 1.00,
      //     navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
      //     navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
      //     navigationRailMutedUnselectedLabel: false,
      //     navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
      //     navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
      //     navigationRailMutedUnselectedIcon: false,
      //     navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      //     navigationRailIndicatorOpacity: 1.00,
      //     navigationRailBackgroundSchemeColor: SchemeColor.surface,
      //     navigationRailLabelType: NavigationRailLabelType.none,
      //   ),
      //   keyColors: const FlexKeyColors(
      //     useSecondary: true,
      //     useTertiary: true,
      //   ),
      //   tones: FlexTones.jolly(Brightness.dark),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   //useMaterial3: true,
      //   //swapLegacyOnMaterial3: true,
      //   fontFamily: GoogleFonts.poppins().fontFamily,
      // ),
      home: BlocProvider(
        create: (_) => SignUpBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
