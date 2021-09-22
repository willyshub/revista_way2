import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.isExpand = false,
    required this.index,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController;
  final bool isExpand;
  final int index; // 1: title; 2: author; 3: abstract;

  @override
  Widget build(BuildContext context) {
    int returnMaxLength() {
      if (index == 1) {
        return 100;
      } else if (index == 2) {
        return 50;
      } else {
        return 500;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      child: TextFormField(
        controller: textEditingController,
        maxLines: isExpand ? 10 : 1,
        cursorColor: AppColors.primary,
        maxLength: returnMaxLength(),
        style: AppTextStyles.inputBold,
        keyboardType: isExpand ? TextInputType.multiline : TextInputType.name,
        decoration: InputDecoration(
          hintStyle: AppTextStyles.input,
          border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primary, style: BorderStyle.none),
          ),
          hintText: hintText,
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            if (index == 1) {
              return "Título inválido ou vazio";
            } else if (index == 2) {
              return "Nome do autor inválido ou vazio";
            } else {
              return "Resumo inválido ou vazio";
            }
          }
          return null;
        },
      ),
    );
  }
}
