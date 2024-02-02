import 'package:Deva_Tracking/view/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/components/custom_bottoast.dart';
import 'package:Deva_Tracking/view/components/custom_button.dart';
import 'package:Deva_Tracking/view/components/custom_dialogs.dart';
import 'package:Deva_Tracking/view/components/custom_textfield.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/login.dart';
import 'package:Deva_Tracking/view_model/config/storage.dart';
import 'package:Deva_Tracking/view_model/providers/user_provider.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:Deva_Tracking/view_model/utils/validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../view_model/utils/font.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/registerScreen";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const RegisterScreen());
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHidden = true;
  bool isHiddenConfirmPass = true;
  bool isHiddenOld = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
  void toggleConfirmPasswordVisibility() =>
      setState(() => isHiddenConfirmPass = !isHiddenConfirmPass);

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    positionController.dispose();
    codeController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
            child: Consumer<UserProvider>(builder: (context, userProv, child) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Зарегистрироваться',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor.white,
                                  fontWeight: AppFontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02.h,
                      ),
                      Text('Пожалуйста, заполните поле ниже',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColor.darkGray,
                                    fontWeight: AppFontWeight.regular,
                                  )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          textField("Введите свое полное имя",
                              TextInputType.name, TextInputAction.next,
                              showEnabledBorder: true,
                              showLabel: true,
                              controller: usernameController,
                              label: "Полное имя",
                              radius: 15,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              filled: true,
                              fillColor: AppColor.red.withOpacity(0.05),
                              showBottomPadding: true,
                              validator: Validators.isRequiredValidator),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02.h,
                          ),
                          textField("Введите адрес электронной почты ",
                              TextInputType.name, TextInputAction.next,
                              showEnabledBorder: true,
                              showLabel: true,
                              controller: emailController,
                              label: "Электронная почта",
                              radius: 15,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              filled: true,
                              fillColor: AppColor.red.withOpacity(0.05),
                              showBottomPadding: true,
                              validator: Validators.emailValidator),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02.h,
                          ),
                          textField(
                              "Введите ваш пароль",
                              TextInputType.visiblePassword,
                              TextInputAction.done,
                              showEnabledBorder: true,
                              showLabel: true,
                              obscureText: isHidden,
                              controller: passwordController,
                              radius: 15,
                              filled: true,
                              fillColor: AppColor.red.withOpacity(0.05),
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                    onTap: togglePasswordVisibility,
                                    child: isHidden
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            child: const Icon(
                                              Icons.visibility_off_outlined,
                                              size: 20,
                                              color: AppColor.darkGray,
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.h),
                                            child: const Icon(
                                              Icons.visibility_outlined,
                                              size: 20,
                                              color: AppColor.darkGray,
                                            ),
                                          )),
                              ),
                              label: "Пароль",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                              showBottomPadding: true,
                              validator: Validators.passwordValidator),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02.h,
                          ),
                          textField(
                              'Подтвердите свой пароль',
                              TextInputType.visiblePassword,
                              TextInputAction.done,
                              showEnabledBorder: true,
                              showLabel: true,
                              obscureText: isHiddenConfirmPass,
                              controller: confirmPasswordController,
                              radius: 15,
                              fillColor: AppColor.red.withOpacity(0.05),
                              filled: true,
                              icon: GestureDetector(
                                  onTap: toggleConfirmPasswordVisibility,
                                  child: isHiddenConfirmPass
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          color: AppColor.darkGray)
                                      : const Icon(Icons.visibility_outlined,
                                          color: AppColor.darkGray)),
                              label: "Подтвердите пароль",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                              showBottomPadding: true, validator: (value) {
                            Validators.changePasswordValidaator(
                                passwordController.text,
                                confirmPasswordController.text);
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02.h,
                          ),
                          textField("Введите должность ", TextInputType.name,
                              TextInputAction.next,
                              showEnabledBorder: true,
                              showLabel: true,
                              controller: positionController,
                              label: "Должность ",
                              radius: 15,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              filled: true,
                              fillColor: AppColor.red.withOpacity(0.05),
                              showBottomPadding: true,
                              validator: Validators.isRequiredValidator),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02.h,
                          ),
                          textField("Введите свой секретный код ",
                              TextInputType.name, TextInputAction.next,
                              showEnabledBorder: true,
                              showLabel: true,
                              controller: codeController,
                              label: "Код",
                              radius: 15,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              searchStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  ),
                              filled: true,
                              fillColor: AppColor.red.withOpacity(0.05),
                              showBottomPadding: true,
                              validator: Validators.isRequiredValidator),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )),
                  Center(
                    child: CustomButton(
                      onTap: () {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final register = {
                              "name": usernameController.text,
                              "email": emailController.text,
                              "position": positionController.text,
                              "password": passwordController.text,
                              "confirm_password":
                                  confirmPasswordController.text,
                              "secret_code": codeController.text,
                            };

                            userProv.register(register: register).then((value) {
                              if (value) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialogs.register(context,
                                          title:
                                              'успешно добавлен новый сотрудник',
                                          onTapOk: () async {
                                        await SecureStorage.deleteData(
                                            AppConstant.accessToken);

                                        // ignore: use_build_context_synchronously
                                        context.pushReplacement(
                                            LoginScreen.routeName);
                                      });
                                    });
                              }
                            });
                          }
                        } else {
                          showBotToast(
                              text: "Пароль не совпадает", isError: true);
                        }
                      },
                      text: "Авторизоваться",
                      width: MediaQuery.of(context).size.width * 0.7,
                      backgroundColor: AppColor.primary1,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02.h,
                  ),
                  InkWell(
                    onTap: () {
                      context.push(LoginScreen.routeName);
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'Уже есть аккаунт?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppColor.darkGray,
                                      fontWeight: AppFontWeight.medium)),
                          TextSpan(
                              text: " Войти",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppColor.primary1,
                                      fontWeight: AppFontWeight.medium))
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
