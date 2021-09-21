import 'package:flutter/material.dart';
import 'package:revista_way2/theme/theme_export.dart';

class ButtonAddAuthor extends StatelessWidget {
  const ButtonAddAuthor({
    Key? key,
    required this.fun,
  }) : super(key: key);

  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.stroke,
          width: AppSize.defaultStroke,
        ),
      ),
      child: Material(
        child: InkWell(
          //splashColor: Colors.red,
          //focusColor: Colors.red,
          onTap: fun,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: AppSize.defaultPadding / 3),
                child: const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.stroke,
                ),
              ),
              Text(
                "Adicionar mais um autor",
                style: AppTextStyles.input,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
