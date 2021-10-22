import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/theme/theme_export.dart';
import 'package:revista_way2/view-model/send_vm.dart';

class ButtonAddAuthorWidget extends StatelessWidget {
  const ButtonAddAuthorWidget({
    Key? key,
    this.twoButton = false,
    required this.fun,
  }) : super(key: key);

  final bool twoButton;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    final colorDelete = Colors.red[200];
    final length = context.watch<SendVM>().listSimpleTextField.length;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 50.0,
      margin: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: twoButton
              ? colorDelete!
              : length == 5
                  ? AppColors.input
                  : AppColors.grey,
          width: AppSize.defaultStroke,

        ),
        borderRadius: BorderRadius.circular(AppSize.defaultBorderRadius),
      ),
      child: Material(
        child: InkWell(
          splashColor: AppColors.primary.withOpacity(0.1),
          onTap: twoButton
              ? fun
              : length == 5
                  ? null
                  : fun,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: AppSize.defaultPadding / 3),
                child: Icon(
                  twoButton
                      ? Icons.person_remove_alt_1_rounded
                      : Icons.person_add_alt_1_rounded,
                  color: twoButton
                      ? colorDelete!
                      : length == 5
                          ? AppColors.input
                          : AppColors.grey,
                ),
              ),
              Text(
                "autor",
                overflow: TextOverflow.ellipsis,
                style: twoButton
                    ? AppTextStyles.buttonBoldGray
                    : length == 5
                        ? AppTextStyles.input
                        : AppTextStyles.buttonBoldGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
