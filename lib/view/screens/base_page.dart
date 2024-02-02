// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:Deva_Tracking/view_model/providers/msg_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/components/custom_button.dart';
import 'package:Deva_Tracking/view/components/custom_dialogs.dart';
import 'package:Deva_Tracking/view/components/custom_textfield.dart';

import 'package:Deva_Tracking/view/components/profile_widgets.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/login.dart';

import 'package:Deva_Tracking/view/screens/mainscreens/news_screen.dart';
import 'package:Deva_Tracking/view/screens/mainscreens/staff_screen.dart';
import 'package:Deva_Tracking/view/screens/sec_code/sec_code.dart';
import 'package:Deva_Tracking/view_model/providers/user_provider.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';
import 'package:Deva_Tracking/view_model/utils/validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_model/config/storage.dart';
import '../../view_model/utils/export_utils.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  static const String routeName = "/basepage";
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const BasePage());
  }

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final TextEditingController usernameController = TextEditingController();
  String? userType = "general";
  String? userName = "Name";
  String? id = "-1";
  String? photo =
      "https://imgs.search.brave.com/hEdySpuEufPvuciR5ChDKWHOHdtvdmi4vJNwS46P8z8/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNi8w/OC8wOC8wOS8xNy9h/dmF0YXItMTU3Nzkw/OV8xMjgwLnBuZw";
  @override
  void initState() {
    // TODO: implement initState
    getusertype();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  Future getusertype() async {
    final String? userTypesaved =
        await SecureStorage.getData(AppConstant.usertype);
    final String? userNamesaved =
        await SecureStorage.getData(AppConstant.username);
    final String? photo2 = await SecureStorage.getData(AppConstant.photo1);
    final String? id2 = await SecureStorage.getData(AppConstant.id);
    setState(() {
      userType = userTypesaved;
      userName = userNamesaved;
      photo = photo2;
      id = id2;
    });
    print(userType);
    print(photo);
  }

  @override
  Widget build(BuildContext context) {
    var userProv = context.watch<UserProvider>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.primary,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Весь чат'),
              Tab(text: 'Новости'),
            ],
            unselectedLabelStyle: TextStyle(
              color: AppColor.darkGray,
              fontSize: AppFontSize.headerOne,
              fontWeight: AppFontWeight.bold,
            ),
            labelStyle: TextStyle(
              color: AppColor.primary1,
              fontSize: AppFontSize.headerOne,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: AppColor.primary,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Consumer<UserProvider>(builder: (context, userProv, child) {
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColor.primary,
                  ),
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileWidget(
                        image: photo,
                        icon: Icons.camera_alt_outlined,
                        ontap: () async {
                          try {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              List<File> files = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              if (files.isNotEmpty) {
                                FormData formData = FormData.fromMap({
                                  "photo": await MultipartFile.fromFile(
                                    files.first.path,
                                    filename: "photo.jpg",
                                  ),
                                  "email": "",
                                  "name": "",
                                });

                                userProv
                                    .update(id: id ?? "", datas: formData)
                                    .then((value) {
                                  if (value) {
                                    context.pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CustomDialogs.register(context,
                                              title:
                                                  'ваш профиль успешно обновлен',
                                              onTapOk: () async {
                                            // ignore: use_build_context_synchronously
                                            context.pushReplacement(
                                                BasePage.routeName);
                                          });
                                        });
                                  }
                                });
                              }
                            }
                          } catch (e) {}
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2,
                            bottom: 0),
                        child: Text(userName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color: AppColor.white,
                                    fontWeight: AppFontWeight.bold)),
                      ),
                    ],
                  ),
                );
              }),
              ListTile(
                  //staff
                  title: Text(
                    'Сотрудники',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.push(StaffScreen.routeName);
                    context.pop();
                  }),

              if (userType!.contains("admin")) ...[
                const Divider(
                  color: AppColor.primary1,
                ),
                ListTile(
                  //generate code
                  title: Text(
                    'новый код',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.push(SecretCode.routeName);
                    context.pop();
                  },
                ),
              ],

              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Отгрузки',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                  title: Text(
                    'План-отгрузки',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.pop();
                  }),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Склад',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                  title: Text(
                    'Производство',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.pop();
                  }),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Задачи',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                  title: Text(
                    'Остатки',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.pop();
                  }),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Приход',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                  title: Text(
                    'Табель',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.pop();
                  }),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Топ продаж',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                  title: Text(
                    'Статистика',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                  ),
                  onTap: () {
                    context.pop();
                  }),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Ассортимент',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
              const Divider(
                color: AppColor.primary1,
              ),
              ListTile(
                title: Text(
                  'Выйти из системы',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                ),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogs.buildWillPopUp(context,
                            title: 'Вы действительно хотите выйти из системы?',
                            onTapOk: () async {
                          await SecureStorage.deleteData(
                              AppConstant.accessToken);
                          // await userProv.logout();
                          context.pushReplacement(LoginScreen.routeName);
                          Navigator.pop(context);
                        });
                      });
                },
              ),

              // 1. Employees 2. Shipments 3. Shipment Plan 4. Warehouse 5. Production 6. Tasks 7. Leftovers 8. Arrival 9. Report card 10. Top sales 11.Statistics 12.Assortment
            ],
          ),
        ),
        body: TabBarView(
          children: [
            chat(usernameController: usernameController),
            Column(
              children: [NewsScreen()],
            ),
          ],
        ),
      ),
    );
  }
}

class chat extends StatefulWidget {
  chat({
    super.key,
    required this.usernameController,
  });

  final TextEditingController usernameController;
  final _formKey = GlobalKey<FormState>();

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  final _formKey = GlobalKey<FormState>();
  late Timer timer;
  bool isWidgetActive = true;
  Future<void> makeMessageCall(MessageProvider msgProv) async {
    final token = await SecureStorage.getData(AppConstant.accessToken);

    log(" tocken $token");
    if (token != null) {
      await msgProv.messages();
    }
  }

  @override
  void initState() {
    super.initState();
    print("InitState");
    Provider.of<MessageProvider>(context, listen: false).messages();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!isWidgetActive) {
        print("Widget not mounted");
        timer
            .cancel(); // Cancel the timer explicitly if the widget is not mounted
        return;
      }
      print("Timer callback");
      makeMessageCall(Provider.of<MessageProvider>(context, listen: false));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    isWidgetActive = false;
    print("Dispose");
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, MessageProvider>(
        builder: (context, userProv, msgProv, child) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .75,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: msgProv.message.length,
                    itemBuilder: (context, index) {
                      // Message message = messages[index];
                      final message = msgProv.message[index];
                      bool isSender = message.messagePosition == "right";

                      // Align messages to the right if the sender is the user, otherwise align to the left
                      AlignmentDirectional alignment = isSender
                          ? AlignmentDirectional.centerEnd
                          : AlignmentDirectional.centerStart;

                      return Align(
                        alignment: alignment,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSender
                                ? AppColor.red.withOpacity(0.5)
                                : AppColor.drawerColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                isSender ? "You" : message.name ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primary1,
                                    ),
                              ),
                              // Text(
                              //   message.message ?? "",
                              //   style: TextStyle(color: Colors.white),
                              // ),
                              if (message.message != null &&
                                  message.message!.isNotEmpty)
                                Text(
                                  message.message ?? "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              if (message.messageImage != null &&
                                  message.messageImage!.isNotEmpty)
                                Image.network(
                                  "https://${message.messageImage}",
                                  // "https://${member.photo}
                                  width: MediaQuery.of(context).size.width * .5,
                                  // height:
                                  //     MediaQuery.of(context).size.height * .3,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.baseline,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .66,
                      child: Form(
                        key: _formKey,
                        child: textField(
                          "сообщение",
                          TextInputType.text,
                          TextInputAction.newline,
                          showEnabledBorder: true,
                          showLabel: true,
                          controller: widget.usernameController,
                          label: "",
                          searchStyle:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.primary1,
                                  ),
                          filled: true,
                          fillColor: AppColor.red.withOpacity(0.05),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                          showBottomPadding: true,
                          validator: Validators.isRequiredValidator,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                try {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    List<File> files = result.paths
                                        .map((path) => File(path!))
                                        .toList();
                                    if (files.isNotEmpty) {
                                      FormData formData = FormData.fromMap({
                                        "image": await MultipartFile.fromFile(
                                          files.first.path,
                                          filename: "photo.jpg",
                                        ),
                                      });

                                      msgProv.picMsg(message: formData);
                                    }
                                  } else {
                                    // User canceled the picker
                                  }
                                } catch (e) {}
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            .01),
                                child: const Icon(
                                  Icons.folder_copy_outlined,
                                  color: AppColor.primary1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .23,
                              child: CustomButton(
                                onTap: () {
                                  final message = {
                                    "message": widget.usernameController.text,
                                  };

                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    msgProv
                                        .sendmessage(message: message)
                                        .then((value) {
                                      // FocusScope.of(context).unfocus();
                                      widget.usernameController.clear();
                                    });
                                  }
                                },
                                text: "Отправить",
                                fontSize: 12.sp,
                                // width: MediaQuery.of(context).size.width * 0.5,
                                backgroundColor: AppColor.primary1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
