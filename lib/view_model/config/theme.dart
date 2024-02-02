import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTheme {
  static ThemeData appTheme() {
    return ThemeData(
        scaffoldBackgroundColor: AppColor.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: AppColor.primary1,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          shadowColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: AppColor.primary1,
            size: 30.h,
          ),
        ),
        fontFamily: "Inter",
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColor.primary1;
              }
              return AppColor.primary;
            },
          ),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColor.white;
            } else {
              return AppColor.black;
            }
          }),
          trackOutlineColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColor.black;
            } else {
              return AppColor.white;
            }
          }),
        ),
        primaryColor: AppColor.primary,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
            primary: AppColor.primary1,
            secondary: AppColor.primary,
            brightness: Brightness.light),
        textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 36, color: AppColor.black),
          bodyLarge: TextStyle(fontSize: 24, color: AppColor.black),
          bodyMedium: TextStyle(fontSize: 22, color: AppColor.black),
          bodySmall: TextStyle(fontSize: 20, color: AppColor.black),
          titleLarge: TextStyle(fontSize: 18, color: AppColor.black),
          titleMedium: TextStyle(fontSize: 16, color: AppColor.black),
          titleSmall: TextStyle(fontSize: 14, color: AppColor.black),
          labelLarge: TextStyle(fontSize: 12, color: AppColor.black),
          labelMedium: TextStyle(fontSize: 11, color: AppColor.black),
          labelSmall: TextStyle(fontSize: 10, color: AppColor.black),
        ),
        splashColor: AppColor.primary);
  }
}
