import 'package:Deva_Tracking/view/components/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';
import 'package:Deva_Tracking/view_model/utils/font.dart';
import 'package:Deva_Tracking/view_model/utils/images.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
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
            child: Text('Мы в разработке. Пожалуйста, оставайтесь на связи',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.white, fontWeight: AppFontWeight.light)),
          ),
        ],
      ),
    );
  }
}
