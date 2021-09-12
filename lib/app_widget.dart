import 'package:flutter/material.dart';
import 'package:revista_way2/view/pages/home/send_page/send_page.dart';
import 'package:revista_way2/view/pages/login/login_page.dart';
import 'view/pages/home/home_page.dart';
import 'view/pages/home/send_page/app_colors.dart';
import 'view/pages/home/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RevistaWAY",
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      initialRoute: "/splash",
      routes: {
        "/home": (context) => HomePage(),
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/send": (context) => SendPage(),
      },
      // home: SplashPage(),
      // //home: LoginPage(),
    );
  }
}
