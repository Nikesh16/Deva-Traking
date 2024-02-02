import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/components/development.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/login.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/register.dart';
import 'package:Deva_Tracking/view/screens/base_page.dart';
import 'package:Deva_Tracking/view/screens/error_page.dart';
import 'package:Deva_Tracking/view/screens/mainscreens/staff_screen.dart';
import 'package:Deva_Tracking/view/screens/on_boarding_screen.dart';
import 'package:Deva_Tracking/view/screens/sec_code/sec_code.dart';
import 'package:Deva_Tracking/view/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

class GoRouteNavigation {
  static final GoRouter _router = GoRouter(
    initialLocation: SplashScreen.routeName,
    observers: [BotToastNavigatorObserver()],
    routes: [
      //SPLASH SCREEN//
      GoRoute(
          path: SplashScreen.routeName,
          name: 'splashscreen',
          builder: (context, state) => const SplashScreen()),
      //Login SCREEN//
      GoRoute(
          path: LoginScreen.routeName,
          name: 'loginScreen',
          builder: (context, state) => const LoginScreen()),
      //register  SCREEN//
      GoRoute(
          path: RegisterScreen.routeName,
          name: 'registerScreen',
          builder: (context, state) => const RegisterScreen()),
      //development  SCREEN//
      GoRoute(
          path: DevelopmentScreen.routeName,
          name: 'developmentScreen',
          builder: (context, state) => const DevelopmentScreen()),
      //staff  SCREEN//
      GoRoute(
          path: StaffScreen.routeName,
          name: 'staffScreen',
          builder: (context, state) => const StaffScreen()),
      //code//
      GoRoute(
          path: SecretCode.routeName,
          name: 'secretCode',
          builder: (context, state) => const SecretCode()),

      //BASEPAGE//

      GoRoute(
          path: OnBoardingScreen.routeName,
          name: 'onboardingScreen',
          builder: (context, state) => const OnBoardingScreen()),

      GoRoute(
          path: CustomErrorPage.routeName,
          name: 'errorPage',
          builder: (context, state) => CustomErrorPage(
                errorDetails: state.extra as FlutterErrorDetails?,
              )),

      GoRoute(
        path: BasePage.routeName,
        name: "basepage",
        builder: (context, state) => const BasePage(),
      ),
    ],
  );

  GoRouter get goRouter => _router;
}
