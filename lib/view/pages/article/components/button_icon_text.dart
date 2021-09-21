import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';

class ButtonIconTextWidget extends StatelessWidget {
  const ButtonIconTextWidget({
    Key? key,
    required this.text,
    required this.function,
    required this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback function;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: function,
      child: Container(
        padding: EdgeInsets.all(AppSize.defaultPadding / 2),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey,
            width: AppSize.defaultStroke,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.defaultPadding / 3,
              ),
              child: Icon(
                icon,
                color: AppColors.grey,
              ),
            ),
            Text(
              text,
              style: AppTextStyles.buttonGray,
            ),
          ],
        ),
      ),
    );
  }
}
