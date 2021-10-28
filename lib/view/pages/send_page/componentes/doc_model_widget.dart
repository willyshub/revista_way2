import 'package:flutter/material.dart';
import 'package:revista_way2/exports/my_classes.dart';
import 'package:revista_way2/model/doc_model.dart';
import 'package:revista_way2/theme/theme_export.dart';

class DocWidgetModel extends StatelessWidget {
  const DocWidgetModel({Key? key, required this.doc, required this.funDelete})
      : super(key: key);
  final DocModel doc;
  final VoidCallback funDelete;

  String showSizeDoc(String value){
    final int length = value.length;
    String start;
    if(length == 6){
      start = value.substring(0, 3);
      return "${start}KB";
    } else if (length == 5){
      start = value.substring(0, 2);
      return "${start}KB";
    } else {
      start = value.substring(0, 1);
      return "${start}KB";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration external
      margin: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      height: 65.0,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.stroke,
          width: AppSize.defaultStroke,
        ),
        borderRadius: BorderRadius.circular(AppSize.defaultBorderRadius),
      ),
      child: Row(
        children: [
          // pdf view
          Expanded(
            child: Container(
              margin: EdgeInsets.all(AppSize.defaultPadding),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf_sharp, color: AppColors.primary),
                  SizedBox(width: AppSize.defaultPadding / 3),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.buttonPrimary,
                        ),
                        Text(
                          showSizeDoc(doc.size.toString()),
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.buttonGray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.defaultPadding),
            child: GestureDetector(
                onTap: funDelete, child: const Icon(Icons.delete_outlined, color: AppColors.delete),
            ),
          ),
        ],
      ),
    );
  }
}
