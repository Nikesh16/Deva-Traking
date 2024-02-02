import 'package:Deva_Tracking/view/components/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/components/custom_button.dart';
import 'package:Deva_Tracking/view/components/custom_textfield.dart';
import 'package:Deva_Tracking/view/screens/base_page.dart';
import 'package:Deva_Tracking/view_model/providers/date_picker_provider.dart';
import 'package:Deva_Tracking/view_model/providers/user_provider.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';
import 'package:Deva_Tracking/view_model/utils/images.dart';
import 'package:Deva_Tracking/view_model/utils/validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SecretCode extends StatefulWidget {
  const SecretCode({super.key});
  static const String routeName = "/secretCode";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SecretCode());
  }

  @override
  State<SecretCode> createState() => _SecretCodeState();
}

class _SecretCodeState extends State<SecretCode> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController todate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Navigator.pop(context);
              context.pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Consumer2<UserProvider, DatePickerProvider>(
            builder: (context, userProv, dateProv, child) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('сгенерируйте секретный код для сотрудников',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.white,
                          fontWeight: AppFontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: Image.asset(
                        CustomImageGetter.code,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                textField("введите свой код ",
                                    TextInputType.name, TextInputAction.done,
                                    showEnabledBorder: true,
                                    showLabel: true,
                                    controller: usernameController,
                                    label: "Сгенерировать код",
                                    radius: 15,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.white,
                                        ),
                                    searchStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.white,
                                        ),
                                    filled: true,
                                    fillColor: AppColor.red.withOpacity(0.05),
                                    showBottomPadding: true,
                                    validator: Validators.isRequiredValidator),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02.h,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02.h,
                                ),
                              ],
                            )),
                        Center(
                          child: CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final loginDatas = {
                                  "name": usernameController.text,
                                };

                                userProv
                                    .generatcode(generate: loginDatas)
                                    .then((value) {
                                  if (value) {
                                    // context.push(BasePage.routeName);

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialogs.register(context,
                                              title: 'код сгенерирован успешно',
                                              onTapOk: () async {
                                            // ignore: use_build_context_synchronously
                                            context.pushReplacement(
                                                BasePage.routeName);
                                          });
                                        });
                                  }
                                });
                              }
                            },
                            text: "Генерировать",
                            width: MediaQuery.of(context).size.width * 0.7,
                            backgroundColor: AppColor.primary1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02.h,
                        ),
                      ],
                    ),
                  ),
                  Text('Удалить сообщение',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.white,
                          fontWeight: AppFontWeight.bold)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02.h,
                  ),
                  Form(
                    key: _formKey2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: textField(
                            "mm/dd/yy",
                            TextInputType.text,
                            TextInputAction.done,
                            showEnabledBorder: true,
                            showLabel: true,
                            // readOnly: true,
                            searchStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.primary1,
                                ),
                            filled: true,
                            fillColor: AppColor.red.withOpacity(0.05),
                            controller: fromDate,
                            label: "От",
                            icon: const Icon(
                              Icons.date_range_sharp,
                              color: AppColor.primary1,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                            showBottomPadding: true,
                            validator: Validators.isRequiredValidator,
                            onPress: () {
                              dateProv
                                  .mainPicker(context,
                                      showPreviousDate: true,
                                      pickDate: false,
                                      pickDateTime: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                      ))
                                  .then((value) {
                                setState(() {
                                  fromDate.text =
                                      DateFormat("yyyy-MM-dd").format(value);
                                });
                              });
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: textField(
                            "mm/dd/yy",
                            TextInputType.text,
                            TextInputAction.done,
                            showEnabledBorder: true,
                            showLabel: true,
                            // readOnly: true,
                            searchStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.white,
                                ),
                            filled: true,
                            fillColor: AppColor.red.withOpacity(0.05),
                            controller: todate,
                            label: "До",
                            icon: const Icon(
                              Icons.date_range_sharp,
                              color: AppColor.primary1,
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                            showBottomPadding: true,
                            validator: Validators.isRequiredValidator,
                            onPress: () {
                              dateProv
                                  .mainPicker(context,
                                      showPreviousDate: true,
                                      pickDate: false,
                                      pickDateTime: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                      ))
                                  .then((value) {
                                setState(() {
                                  todate.text =
                                      DateFormat("yyyy-MM-dd").format(value);
                                });
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02.h,
                  ),
                  Center(
                    child: CustomButton(
                      onTap: () {
                        if (_formKey2.currentState!.validate()) {
                          _formKey2.currentState!.save();
                          final deletedatamsg = {
                            "from": fromDate.text,
                            "to": todate.text,
                          };

                          userProv
                              .deleteusermsg(deletedatamsg: deletedatamsg)
                              .then((value) {
                            context.push(BasePage.routeName);
                          });
                        }
                      },
                      text: "Удалить сообщение",
                      width: MediaQuery.of(context).size.width * 0.7,
                      backgroundColor: AppColor.primary1,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
