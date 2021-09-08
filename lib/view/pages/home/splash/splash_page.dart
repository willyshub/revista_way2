import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/view/pages/home/send_page/app_colors.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
    return splash();
    //   return FutureBuilder(
    //     future: Future.delayed(
    //       Duration(milliseconds: 100),
    //     ),
    //     builder: (context, time) {
    //       if (time.connectionState == ConnectionState.done) {
    //         return HomePage();
    //       } else if (time.connectionState == ConnectionState.waiting) {
    //         return splash();
    //       } else {
    //         return Material(child: Center(child: CircularProgressIndicator()));
    //       }
    //     },
    //   );
  }
}

Scaffold splash() {
  return Scaffold(
    backgroundColor: AppColors.primary,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: "Revista",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 50.0),
              children: [
                TextSpan(
                    text: "WAY", style: TextStyle(fontWeight: FontWeight.w300))
              ],
            ),
          ),
          SizedBox(
            height: AppSize.defaultPadding,
          ),
          CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
