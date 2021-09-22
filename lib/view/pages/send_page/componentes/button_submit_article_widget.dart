import 'package:flutter/material.dart';
import 'package:revista_way2/theme/theme_export.dart';

class ButtonSubmitArticleWidget extends StatelessWidget {
  const ButtonSubmitArticleWidget({
    Key? key,
    required VoidCallback this.function,
  }) : super(key: key);

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: AppSize.defaultPadding * 2),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(100),
      ),
      width: AppSize.getWidth(context),
      child: TextButton(
        onPressed: function,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Center(
          child: Text(
            "Enviar",
            style: AppTextStyles.titleBoldBackground,
          ),
        ),
      ),
    );
  }
}
