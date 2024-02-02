import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';

class CustomErrorPage extends StatelessWidget {
  const CustomErrorPage({
    super.key,
    this.errorDetails,
  });

  final FlutterErrorDetails? errorDetails;

  static const String routeName = "/errorpage";
  static Route route({FlutterErrorDetails? errorDetails}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CustomErrorPage(
              errorDetails: errorDetails,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('${AppConstant.imageFolderPath}/logo.png'),
            Text(
              kDebugMode
                  ? "${errorDetails?.summary ?? "'Something went wrong!'"}"
                  : 'Aaaahhhh!! Something went wrong!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kDebugMode ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We are working on it",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
