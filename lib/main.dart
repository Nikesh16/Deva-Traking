import 'package:Deva_Tracking/view/screens/error_page.dart';
import 'package:Deva_Tracking/view_model/config/routes.dart';
import 'package:Deva_Tracking/view_model/providers/date_picker_provider.dart';
import 'package:Deva_Tracking/view_model/providers/msg_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'view_model/config/theme.dart';
import 'view_model/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MessageProvider()),
    ChangeNotifierProvider(create: (_) => DatePickerProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        builder: (context, widget) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Kushal App chat application  ',

            // routerConfig: GoRouteNavigation().goRouter,
            routerDelegate: GoRouteNavigation().goRouter.routerDelegate,
            routeInformationProvider:
                GoRouteNavigation().goRouter.routeInformationProvider,
            routeInformationParser:
                GoRouteNavigation().goRouter.routeInformationParser,
            theme: CustomTheme.appTheme(),

            builder: (context, widget) {
              widget = BotToastInit()(context, widget);
              widget =
                  ResponsiveBreakpoints.builder(child: widget, breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              ]);
              widget = errorInit(context, widget);
              return widget!;
            },
          );
        });
  }

  // to show errors in a custom error page.
  static errorInit(BuildContext context, Widget? widget) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return CustomErrorPage(errorDetails: errorDetails);
    };
    return widget!;
  }
}

//to remove the blue scoll effect while clamping.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
