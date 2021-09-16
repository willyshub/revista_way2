import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.isExpand = false,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController;
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLines: isExpand ? 10 : 1,
      cursorColor: AppColors.primary,
      keyboardType: isExpand ? TextInputType.multiline : TextInputType.name,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        hintText: hintText,
      ),
    );
  }
}
