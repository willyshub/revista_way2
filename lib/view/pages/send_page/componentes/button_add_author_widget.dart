import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/theme/theme_export.dart';
import 'package:revista_way2/view-model/send_vm.dart';

class ButtonAddAuthorWidget extends StatelessWidget {
  const ButtonAddAuthorWidget({
    Key? key,
    required this.fun,
  }) : super(key: key);

  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    final length = context.watch<SendVM>().listSimpleTextField.length;

    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: length == 5 ? AppColors.input : AppColors.grey,
          width: AppSize.defaultStroke,
        ),
      ),
      child: Material(
        child: InkWell(
          splashColor: AppColors.primary.withOpacity(0.1),
          onTap: length == 5 ? null : fun,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: AppSize.defaultPadding / 3),
                child: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: length == 5 ? AppColors.input : AppColors.grey,
                ),
              ),
              Text(
                "Adicionar mais um autor",
                overflow: TextOverflow.ellipsis,
                style: length == 5
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
