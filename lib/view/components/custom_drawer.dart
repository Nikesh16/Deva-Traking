import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6.w,
      child: Container(
        decoration:
            BoxDecoration(color: AppColor.white, border: Border.all(width: 0)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppColor.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.16.h,
                        child: DrawerHeader(
                          decoration: const BoxDecoration(
                              color: AppColor.white,
                              border: Border(bottom: BorderSide.none)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColor.red.withOpacity(0.5),
                                child: const Icon(
                                  Icons.person,
                                  color: AppColor.red,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                "Kabir Bansha",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: AppFontWeight.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ...List.generate(drawerProv.allDrawerList.length,
                          //     (index) {
                          //   final drawerDatas =
                          //       drawerProv.allDrawerList[index];

                          //   return DrawerListtileWidget(
                          //     title: drawerDatas.title!,
                          //     icon: drawerProv.getIconsFroDrawerWidgets(
                          //         drawerDatas.title!),
                          //     // slug: drawerDatas.slug!,
                          //     dropDown: (drawerDatas.cmsPage != null
                          //         ? (drawerDatas.cmsPage!.isNotEmpty
                          //             ? CustomImageGetter.downIcon
                          //             : null)
                          //         : null),
                          //     dropdownList: (drawerDatas.cmsPage != null
                          //         ? (drawerDatas.cmsPage!.isNotEmpty
                          //             ? drawerDatas.cmsPage!.map((cmsPage) {
                          //                 return {
                          //                   'title': cmsPage.title ?? '',
                          //                   'value': cmsPage.slug ??
                          //                       '', // Change this line based on the desired second value
                          //                 };
                          //               }).toList()
                          //             : null)
                          //         : null),
                          //     expandedTap: (value) {
                          //       // print(value);
                          //       if (drawerDatas.title?.toLowerCase() !=
                          //           'news and events') {
                          //         // print(value);
                          //         drawerProv
                          //             .fetchCmsDescription(slug: value)
                          //             .then((homeList) {
                          //           if (homeList.isNotEmpty) {
                          //             context.push(
                          //                 DescriptionScreen.routeName,
                          //                 extra: DescriptionScreenArgs(
                          //                     homeDataList: homeList));
                          //           }
                          //         });
                          //       } else {
                          //         drawerProv
                          //             .fetchNewsDescription(slug: value)
                          //             .then((homeList) {
                          //           // print(homeList);
                          //           if (homeList.isNotEmpty) {
                          //             context.push(
                          //                 DescriptionScreen.routeName,
                          //                 extra: DescriptionScreenArgs(
                          //                     homeDataList: homeList));
                          //           }
                          //         });
                          //       }
                          //     },
                          //     color: drawerProv.drawerIndex == index
                          //         ? AppColor.primary
                          //         : null,
                          //     nextTap: () {
                          //       if (index == 0) {
                          //         baseProv
                          //             .changeCurrentPageIndex(0, context)
                          //             .then((value) {
                          //           context
                          //               .pushReplacement(Basepage.routeName);
                          //         });
                          //       } else if (index == 1) {
                          //         context.push(TreeScreen.routeName);
                          //       } else if (index == 2) {
                          //         drawerProv
                          //             .fetchCmsDescription(slug: "blog")
                          //             .then((homeList) {
                          //           if (homeList.isNotEmpty) {
                          //             context.push(
                          //                 DescriptionScreen.routeName,
                          //                 extra: DescriptionScreenArgs(
                          //                     homeDataList: homeList));
                          //           }
                          //         });
                          //       }
                          //       drawerProv.changeDrawerIndex(index);
                          //     },
                          //   );
                          // }),
                          // DrawerListtileWidget(
                          //   title: 'Logout',
                          //   // slug: '',
                          //   nextTap: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return CustomDialogs.buildWillPopUp(
                          //               context,
                          //               title: 'Are you sure to logout?',
                          //               onTapOk: () async {
                          //             await SecureStorage.deleteData(
                          //                 AppConstant.accessToken);
                          //             baseProv.toggleIsLoggedIn(false);
                          //             await SecureStorage.deleteData(
                          //                 AppConstant.isLoggedIn);

                          //             // ignore: use_build_context_synchronously
                          //             context.pushReplacement(
                          //                 LoginScreen.routeName);
                          //           });
                          //         });
                          //   },
                          //   icon: CustomImageGetter.donationIcon,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    // SvgPicture.asset(CustomImageGetter.switchIcon),
                    SizedBox(
                      width: 16.0.w,
                    ),
                    const Text(
                      "Switch Genealogy",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: AppFontWeight.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
