import 'package:flutter/material.dart';
import 'package:revista_way2/theme/theme_export.dart';

class ButtonAttachDoc extends StatelessWidget {
  const ButtonAttachDoc({
    Key? key,
    required VoidCallback this.function,
  }) : super(key: key);

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Container(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.heading,
            width: AppSize.defaultStroke,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        width: AppSize.getWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: AppSize.defaultPadding / 3),
              child: const Icon(
                Icons.attach_file_rounded,
                color: AppColors.heading,
              ),
            ),
            Text(
              "Anexar Documento",
              style: AppTextStyles.titleListTile,
            ),
          ],
        ),
      ),
    );
  }
}
