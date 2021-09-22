import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.titleBoldHeading,
    );
  }
}
