import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/utils/colors.dart';

class CustomDialogs {
  static AlertDialog buildWillPopUp(
    context, {
    String? title,
    String? subtext,
    FontWeight? weight,
    Color? tcolor,
    Color? scolor,
    Color? backgroundColor,
    Function()? onTapOk,
    Function()? onTapCancel,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '${AppConstant.imageFolderPath}/logo.png',
                height: 50,
              ),
              SizedBox(
                width: 20.w,
              ),
              const Text("Deva Tracking ")
            ],
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffC5BFBF),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Вы действительно хотите выйти ?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: weight ?? FontWeight.bold,
              color: tcolor ?? Colors.black,
            ),
          ),
          Visibility(
            visible: subtext != null,
            child: Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Center(
                child: Text(
                  subtext ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: scolor ?? Colors.black,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2.0,
                  ),
                  // textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onTapOk ??
              () {
                exit(0);
              },
          child: Text(
            'Да'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: AppColor.primary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onTapCancel ?? () => Navigator.pop(context),
          child: const Text(
            'Отмена',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: AppColor.primary,
            ),
          ),
        ),
      ],
    );
  }

  static AlertDialog register(
    context, {
    String? title,
    Function()? onTapOk,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '${AppConstant.imageFolderPath}/logo.png',
                height: 50,
              ),
              SizedBox(
                width: 20.w,
              ),
              const Text("Deva Tracking ")
            ],
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffC5BFBF),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Вы действительно хотите выйти ?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onTapOk ?? () {},
          child: Text(
            'ладно'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
