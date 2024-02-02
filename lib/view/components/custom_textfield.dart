import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';

typedef CustomValidation = String? Function(String?)?;
Widget textField(
  String hintText,
  TextInputType inputType,
  TextInputAction action, {
  String? label,
  Widget? icon,
  Function()? onPress,
  Widget? prefixIcon,
  TextEditingController? controller,
  bool? obscureText,
  CustomValidation validator,
  final bool isCustomHeight = false,
  Function(String)? onChange,
  Function(String)? onSubmitted,
  bool readOnly = false,
  bool isRichText = false,
  bool filled = false,
  Color? fillColor,
  Widget? labelRowWidget,
  bool bottomLabel = false,
  bool showLabel = true,
  bool showEnabledBorder = false,
  bool showUnderLine = true,
  int? maxLength,
  final TextStyle? searchStyle,
  final TextStyle? hintStyle,
  final Color? labelColor,
  final Color? borderColor,
  final double? radius,
  final bool showDivider = false,
  final TextStyle? labelStyle,
  final EdgeInsets? scrollPadding,
  final EdgeInsetsGeometry? contentPadding,
  final FocusNode? focusNode,
  int? maxLines = 1,
  final double? top,
  final double? bottom,
  final double? left,
  final double? right,
  final double? textFieldHeight,
  final double? textFieldWidth,
  final Widget? stackIcon,
  final Widget? subTitleWidget,
  final bool showSubtitle = false,
  final bool showBottomPadding = false,
  final String? fontFamily,
  final double? hintSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      showLabel
          ? (Padding(
              padding: EdgeInsets.only(bottom: showBottomPadding ? 10 : 0),
              child: isRichText
                  ? RichText(
                      text: TextSpan(
                          text: label,
                          style: labelStyle ??
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.primary),
                          children: const [
                          TextSpan(
                            text: " *",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, color: Colors.red),
                          ),
                        ]))
                  : showSubtitle
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  label ?? '',
                                  style: labelStyle ??
                                      const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          color: AppColor.primary),
                                ),
                                labelRowWidget ?? const SizedBox()
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            subTitleWidget ?? const SizedBox.shrink()
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label ?? '',
                              style: labelStyle ??
                                  const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      color: AppColor.primary),
                            ),
                            labelRowWidget ?? const SizedBox()
                          ],
                        ),
            ))
          : const SizedBox.shrink(),
      isCustomHeight
          ? SizedBox(
              height: textFieldHeight,
              width: textFieldWidth,
              child: TextFormField(
                maxLines: maxLines,
                keyboardType: inputType,
                textInputAction: action,
                controller: controller,
                obscureText: obscureText ?? false,
                validator: validator,
                onTap: onPress,
                readOnly: readOnly,
                maxLength: maxLength,
                onFieldSubmitted: onSubmitted,
                focusNode: focusNode,
                onChanged: onChange,
                scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
                // scrollPadding: EdgeInsets.zero,
                // style: const TextStyle(
                //     fontWeight: FontWeight.normal, color: Colors.black),
                style: searchStyle,
                decoration: InputDecoration(
                    errorMaxLines: 2,
                    filled: filled,
                    fillColor: fillColor,
                    counterText: '',
                    contentPadding: contentPadding ??
                        const EdgeInsets.fromLTRB(12, 12, 0, 12),
                    hintStyle: TextStyle(
                        fontSize: hintSize ?? 10,
                        color: AppColor.darkGray,
                        fontFamily: fontFamily ?? 'Poppins',
                        fontWeight: FontWeight.w300),
                    errorBorder: showEnabledBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius ?? 7.5),
                            borderSide:
                                BorderSide(color: borderColor ?? Colors.red),
                          )
                        : (showUnderLine
                            ? const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.red, width: 1))
                            : InputBorder.none),
                    focusedErrorBorder: showEnabledBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius ?? 7.5),
                            borderSide: BorderSide(
                                color: borderColor ?? AppColor.primary),
                          )
                        : (showUnderLine
                            ? const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.primary, width: 1))
                            : InputBorder.none),
                    focusedBorder: showEnabledBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius ?? 7.5),
                            borderSide: BorderSide(
                                color: borderColor ?? AppColor.darkGray),
                          )
                        : (showUnderLine
                            ? const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.darkGray, width: 1))
                            : InputBorder.none),
                    enabledBorder: showEnabledBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius ?? 7.5),
                            borderSide: BorderSide(
                                color: borderColor ?? AppColor.darkGray),
                          )
                        : (showUnderLine
                            ? const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.darkGray, width: 1))
                            : InputBorder.none),
                    prefixIcon: prefixIcon,
                    suffixIcon: icon,

                    // IconButton(onPressed: onTap, icon: icon ?? const SizedBox()),
                    hintText: hintText,
                    errorStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: AppFontWeight.medium)),
              ),
            )
          : Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextFormField(
                  maxLines: maxLines,
                  keyboardType: inputType,
                  textInputAction: action,
                  controller: controller,
                  obscureText: obscureText ?? false,
                  validator: validator,
                  onTap: onPress,
                  readOnly: readOnly,
                  maxLength: maxLength,
                  onFieldSubmitted: onSubmitted,
                  focusNode: focusNode,
                  onChanged: onChange,
                  scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
                  // scrollPadding: EdgeInsets.zero,
                  // style: const TextStyle(
                  //     fontWeight: FontWeight.normal, color: Colors.black),
                  style: searchStyle,
                  decoration: InputDecoration(
                      errorMaxLines: 2,
                      filled: filled,
                      fillColor: fillColor,
                      counterText: '',
                      contentPadding: contentPadding ??
                          const EdgeInsets.fromLTRB(12, 12, 0, 12),
                      hintStyle: hintStyle ??
                          TextStyle(
                              fontSize: hintSize ?? 14,
                              color: AppColor.darkGray,
                              fontFamily: fontFamily ?? 'Poppins',
                              fontWeight: FontWeight.w300),
                      errorBorder: showEnabledBorder
                          ? OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(radius ?? 7.5),
                              borderSide:
                                  BorderSide(color: borderColor ?? Colors.red),
                            )
                          : (showUnderLine
                              ? const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.red, width: 1))
                              : InputBorder.none),
                      focusedErrorBorder: showEnabledBorder
                          ? OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(radius ?? 7.5),
                              borderSide: BorderSide(
                                  color: borderColor ?? AppColor.primary),
                            )
                          : (showUnderLine
                              ? const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.primary, width: 1))
                              : InputBorder.none),
                      focusedBorder: showEnabledBorder
                          ? OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(radius ?? 7.5),
                              borderSide: BorderSide(
                                  color: borderColor ?? AppColor.darkGray),
                            )
                          : (showUnderLine
                              ? const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.darkGray, width: 1))
                              : InputBorder.none),
                      enabledBorder: showEnabledBorder
                          ? OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(radius ?? 7.5),
                              borderSide: BorderSide(
                                  color: borderColor ?? AppColor.darkGray),
                            )
                          : (showUnderLine
                              ? const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColor.darkGray, width: 1))
                              : InputBorder.none),
                      prefixIcon: prefixIcon,
                      suffixIcon: icon,

                      // IconButton(onPressed: onTap, icon: icon ?? const SizedBox()),
                      hintText: hintText,
                      errorStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: AppFontWeight.medium)),
                ),
                Positioned(
                    top: top,
                    bottom: bottom,
                    left: left,
                    right: right,
                    child: stackIcon ??
                        const SizedBox(
                          height: 0,
                          width: 0,
                        ))
              ],
            ),
      bottomLabel
          ? Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label ?? '',
                    style: labelStyle ??
                        TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: labelColor ?? AppColor.primary),
                  ),
                  labelRowWidget ?? const SizedBox()
                ],
              ),
            )
          : const SizedBox.shrink(),
      showDivider
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.5,
                ),
                Divider(
                  color: AppColor.darkGray,
                  thickness: 0.5,
                  height: .5,
                ),
                SizedBox(
                  height: 11.5,
                ),
              ],
            )
          : const SizedBox.shrink()
    ],
  );
}
