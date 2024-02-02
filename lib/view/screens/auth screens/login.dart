import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/register.dart';
import 'package:Deva_Tracking/view_model/config/storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../view_model/providers/user_provider.dart';
import '../../../view_model/utils/export_utils.dart';
import '../../../view_model/utils/font.dart';
import '../../../view_model/utils/validators.dart';
import '../../export_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/loginScreen";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (value) {
          return;
        }
        showDialog(
            context: context,
            builder: (context) => CustomDialogs.buildWillPopUp(context));
      },
      child: Scaffold(
          backgroundColor: AppColor.primary,
          body: SingleChildScrollView(
            child: Consumer<UserProvider>(builder: (context, userProv, child) {
              return Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: Center(
                        child: Image.asset(
                          CustomImageGetter.login,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Вход в систему',
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
                        Text('Пожалуйста, войдите, чтобы продолжить',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppColor.darkGray,
                                  fontWeight: AppFontWeight.regular,
                                )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textField("Введите адрес электронной почты ",
                                TextInputType.name, TextInputAction.next,
                                showEnabledBorder: true,
                                showLabel: true,
                                controller: usernameController,
                                label: "Электронная почта",
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
                                validator: Validators.emailValidator),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02.h,
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
                                validator: Validators.isRequiredValidator),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02.h,
                            ),
                          ],
                        )),
                    Center(
                      child: CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final loginDatas = {
                              "email": usernameController.text,
                              "password": passwordController.text
                            };
                            userProv
                                .loginUser(loginDatas: loginDatas)
                                .then((value) {
                              if (value) {
                                print(value);
                                context.push(BasePage.routeName);
                              } else {}
                            });
                          }
                        },
                        text: "Войти",
                        width: MediaQuery.of(context).size.width * 0.7,
                        backgroundColor: AppColor.primary1,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(RegisterScreen.routeName);
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: 'У вас нет учетной записи?',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: AppColor.darkGray,
                                        fontWeight: AppFontWeight.medium)),
                            TextSpan(
                                text: " Зарегистрироваться",
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
                ),
              );
            }),
          )),
    );
  }
}
