// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';
import '../../../theme/app_size.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return splash(context);
  }
}

Scaffold splash(BuildContext context) => Scaffold(
      body: Stack(
        children: [
          Container(
            height: AppSize.getHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                  /*   AppColors.primary.withOpacity(0.7),
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary.withOpacity(0.9),
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary.withOpacity(0.7),
                    AppColors.primary.withOpacity(0.8), */
                    AppColors.primary.withOpacity(0.6),
                    AppColors.primary,
                  ]),
            ),
          ),
          /* RichText(
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
          ), */
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              filterQuality: FilterQuality.high,
              height: 300.0,
            ),
          ),
          Center(
            child: Container(
              height: 285,
              width: 285,
              child: const CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
