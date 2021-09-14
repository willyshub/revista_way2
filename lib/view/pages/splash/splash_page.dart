// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';
import '../../../theme/app_size.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return splash();
  }
}

Scaffold splash() => Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Revista',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 50.0),
                children: [
                  TextSpan(
                    text: 'WAY',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.defaultPadding,
            ),
            const CircularProgressIndicator(
              strokeWidth: 1.5,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
