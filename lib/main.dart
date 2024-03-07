import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usiiname/components/donation_request.dart';
import 'package:usiiname/components/onboarding_cubit.dart';
import 'package:usiiname/features/loginfeature/presentation/bloc/login_bloc.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/firebase_options.dart';
import 'package:usiiname/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/utils/fcm_manager.dart';
import 'package:usiiname/utils/logger.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   //todo: store incoming messages
//   print("Handling a background message: ${message.messageId}");
// }

final navigatorKey = GlobalKey<NavigatorState>();
Future main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FCMManager().initNotifications();
    await dotenv.load(fileName: ".env");
    Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY'] ?? '');
    return runApp(const ProviderScope(child: Usiiname()));
  }, (error, stack) {
    return runApp(MaterialApp(
      home: ErrorLogger(error: error.toString()),
    ));
  });
}

class Usiiname extends ConsumerWidget {
  const Usiiname({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeStateProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/donation-requests': (context) => const DonationRequests()},
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      navigatorKey: navigatorKey,
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xffe53935),
          primaryContainer: Color(0xff252a32),
          secondary: Color(0xffd17842),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xff0c0f14),
          tertiaryContainer: Color(0xff52555a),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        appBarStyle: FlexAppBarStyle.surface,
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
          snackBarBackgroundSchemeColor: SchemeColor.onPrimaryContainer,
          snackBarActionSchemeColor: SchemeColor.primary,
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
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xffe53935),
          primaryContainer: Color(0xff252a32),
          secondary: Color(0xffd17842),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xff0c0f14),
          tertiaryContainer: Color(0xff52555a),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        subThemesData: const FlexSubThemesData(
          interactionEffects: false,
          tintedDisabledControls: false,
          useTextTheme: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
          alignedDropdown: true,
          tooltipRadius: 4,
          tooltipSchemeColor: SchemeColor.inverseSurface,
          tooltipOpacity: 0.9,
          useInputDecoratorThemeInDialogs: true,
          snackBarElevation: 6,
          snackBarBackgroundSchemeColor: SchemeColor.onPrimaryContainer,
          snackBarActionSchemeColor: SchemeColor.primary,
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
        tones: FlexTones.jolly(Brightness.dark),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SignUpBloc(),
          ),
          BlocProvider(
            create: (_) => OnboardingCubit(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}

final themeStateProvider = StateProvider<bool>((ref) {
  return false;
});
