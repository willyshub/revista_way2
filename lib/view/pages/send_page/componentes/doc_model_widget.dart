import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:revista_way2/model/doc_model.dart';
import 'package:revista_way2/theme/theme_export.dart';

class DocWidgetModel extends StatelessWidget {
  const DocWidgetModel({Key? key, required this.doc, required this.funDelete})
      : super(key: key);
  final DocModel doc;
  final VoidCallback funDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration external
      margin: EdgeInsets.only(top: AppSize.defaultPadding / 3),
      height: 50.0,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.stroke,
          width: AppSize.defaultStroke,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // pdf view
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (doc.extension == "pdf") {
                  final pdfController = PdfController(
                    document: PdfDocument.openFile(doc.path),
                  );

                  Widget pdfView() => PdfView(
                        controller: pdfController,
                        documentLoader: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        pageLoader: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pdfView(),
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.all(AppSize.defaultPadding),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_sharp),
                    SizedBox(width: AppSize.defaultPadding / 3),
                    Text(
                      doc.name,
                      style: AppTextStyles.buttonHeading,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: funDelete, icon: const Icon(Icons.delete_outlined)),
        ],
      ),
    );
  }
}
