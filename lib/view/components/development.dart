import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';
import 'package:Deva_Tracking/view_model/utils/images.dart';
import 'package:go_router/go_router.dart';

class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});
  static const String routeName = "/developmentScreen";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const DevelopmentScreen());
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: Center(
                child: Image.asset(
                  CustomImageGetter.workunder,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.02,
              ),
              child: Text(
                  'Мы находимся в постоянном развитии. Пожалуйста, оставайтесь на связи для получения последних обновлений',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColor.white, fontWeight: AppFontWeight.light)),
            ),
          ],
        ),
      ),
    );
  }
}
