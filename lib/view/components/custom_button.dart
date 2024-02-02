import 'package:flutter/material.dart';

import '../../view_model/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.fontFamily,
      this.padding,
      this.width,
      this.fontSize,
      this.margin});
  final String text;
  final VoidCallback onTap;
  final String? fontFamily;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.primary,
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        child: Center(
          child: Padding(
            padding: padding ??
                const EdgeInsets.only(
                  top: 11.0,
                  bottom: 11.0,
                ),
            child: Text(
              text,
              style: TextStyle(
                color: AppColor.primary,
                // fontWeight: CgFontWeight.medium,
                fontSize: fontSize,
                fontFamily: fontFamily ?? "Inter",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
