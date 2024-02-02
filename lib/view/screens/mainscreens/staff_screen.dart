import 'package:Deva_Tracking/view/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view/components/profile_tile.dart';
import 'package:Deva_Tracking/view_model/export_view_model.dart';
import 'package:Deva_Tracking/view_model/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});
  static const String routeName = "/staffScreen";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const StaffScreen());
  }

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  String? userType = "general";

  @override
  void initState() {
    // TODO: implement initState
    getusertype();
    Provider.of<UserProvider>(context, listen: false).member();
    super.initState();
  }

  Future getusertype() async {
    final String? userTypesaved =
        await SecureStorage.getData(AppConstant.usertype);

    setState(() {
      userType = userTypesaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(builder: (context, userProv, child) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: userProv.memberList.length,
                itemBuilder: (context, index) {
                  bool isAdmin = userType == "admin";
                  final member = userProv.memberList[index];
                  // String? memberPic = "https://dfbasa.ru/${member.photo}";
                  String? imageUrl = member.photo!.isNotEmpty
                      ? "https://${member.photo}"
                      : AppConstant.userPlaceholderImage;

                  return TilePlayerScreen(
                    subtitle: member.position ?? "",
                    title: member.name ?? "",
                    imageUrl: imageUrl,
                    iconData1: isAdmin ? Icons.delete : null,
                    delete1: () {
                      userProv
                          .deleteuser(id: member.id.toString())
                          .then((value) {
                        if (value) {
                          context.push(BasePage.routeName);
                        }
                      });
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
