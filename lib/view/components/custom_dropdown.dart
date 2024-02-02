import 'package:flutter/material.dart';

import '../../model/app_models/drop_down_value_model.dart';
import '../../view_model/utils/colors.dart';

typedef DropDownValueFunction = void Function(String?);

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      this.label,
      this.isRichText = true,
      this.hintText = "",
      this.isExpanded = false,
      required this.itemList,
      this.initalValue,
      required this.dropDownValueFunction,
      this.hintTextStyle,
      this.iconSize,
      this.showBorder = true,
      this.showCustomHeight = false,
      this.textStyle,
      this.getValue = true,
      this.onTapItems,
      this.borderColor,
      this.showLabel = true,
      this.labelTextStyle,
      this.labelColor,
      this.iconWidget,
      this.showTextPostIntGetText = false});
  final String? label;
  final bool isRichText;
  final String hintText;
  final TextStyle? hintTextStyle;
  final bool showBorder;
  final bool isExpanded;
  final List<DropDownValueModel> itemList;
  final String? initalValue;
  final DropDownValueFunction dropDownValueFunction;

  final bool showLabel;
  final double? iconSize;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final Function()? onTapItems;
  final bool showCustomHeight;
  final bool getValue;
  final Color? borderColor;
  final Widget? iconWidget;
  final Color? labelColor;
  final bool showTextPostIntGetText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRichText
            ? RichText(
                text: TextSpan(
                    text: label,
                    style: labelTextStyle ??
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkCharcoal,
                            fontSize: 14),
                    children: [
                    TextSpan(
                      text: " *",
                      style: labelTextStyle ??
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.red,
                              fontSize: 14),
                    ),
                  ]))
            : showLabel
                ? Text(
                    label ?? '',
                    style: labelTextStyle ??
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: labelColor ?? AppColor.darkCharcoal,
                            fontSize: 14),
                  )
                : const SizedBox.shrink(),
        showLabel
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        DecoratedBox(
          decoration: BoxDecoration(
            border: showBorder
                ? Border(
                    bottom:
                        BorderSide(color: borderColor ?? Colors.grey.shade300))
                : const Border(),
            // borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton(
            hint: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                hintText,
                overflow: TextOverflow.ellipsis,
                style: hintTextStyle ??
                    Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.darkGray,
                        fontSize: 14),
              ),
            ),
            underline: const SizedBox.shrink(),
            isExpanded: isExpanded,
            value: initalValue,
            icon: Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: iconWidget ??
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: iconSize ?? 28,
                      color: AppColor.darkGray,
                    )),
            items: itemList.map((model) {
              return DropdownMenuItem(
                value: getValue ? model.id : model.value,
                onTap: onTapItems,
                child: showCustomHeight
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text(
                          model.value,
                          style: textStyle ??
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.black,
                                  fontSize: 14),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          model.value,
                          style: textStyle ??
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.black,
                                  fontSize: 14),
                        ),
                      ),
              );
            }).toList(),
            onChanged: (newValue) {
              dropDownValueFunction.call(newValue as String);
              // initalValue = newValue as String;
            },
          ),
        ),
      ],
    );
  }
}
