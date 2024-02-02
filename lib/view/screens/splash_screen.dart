import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Deva_Tracking/view/export_view.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/login.dart';
import 'package:Deva_Tracking/view/screens/base_page.dart';
import 'package:Deva_Tracking/view_model/config/storage.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:Deva_Tracking/view_model/utils/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "/splashscreen";
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // context.pushReplacement(LoginScreen.routeName);
      checkForTokenAndRememberMe();
    });
  }

  Future<void> checkForTokenAndRememberMe() async {
    final token = await SecureStorage.getData(AppConstant.accessToken);

    log("$token");

    if (token != null) {
      if (!mounted) return;
      context.pushReplacement(BasePage.routeName);
    } else {
      if (!mounted) return;
      context.pushReplacement(LoginScreen.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    checkForTokenAndRememberMe();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                CustomImageGetter.logo,
                height: 125.h,
                width: 125.w,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
