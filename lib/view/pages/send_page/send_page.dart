import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:open_file/open_file.dart';
import 'package:revista_way2/model/doc_model.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/send_bloc.dart';

class SendPage extends StatefulWidget {
  SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  SendBloc bloc = SendBloc();

  var titleController = TextEditingController();

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool a) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  text: "Enviar",
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: " arquivo",
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPadding,
            vertical: AppSize.defaultPadding,
          ),
          shrinkWrap: true,
          children: [
            /*
            String title;
            String authors;
            String abstract;
            DocModel doc;
            */
            Padding(
              padding: EdgeInsets.only(bottom: AppSize.defaultPadding / 2),
              child: Text(
                "Título",
                style: AppTextStyles.titleBoldHeading,
              ),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Título do arquivo',
              ),
            ),
            customSizedBox(),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Autores',
              ),
            ),
            customSizedBox(),
            Container(
              height: 80,
              width: AppSize.getWidth(context),
              child: TextButton(
                onPressed: () async {
                  bloc.getDoc();
                },
                child: Row(
                  children: [
                    Icon(Icons.attach_file_rounded),
                    Text(
                      "Anexar Doc",
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<List<DocModel>>(
                stream: bloc.myStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DocWidgetModel(doc: bloc.docList.first);
                    /*return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bloc.docList.length,
                      itemBuilder: (context, index) {
                        return DocWidgetModel(doc: bloc.docList[index]);
                      },
                    );*/
                  } else {
                    return Center(
                      child: Text(
                        "Anexe seu artigo",
                        style: AppTextStyles.input,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(
        height: AppSize.defaultPadding,
      );
}

class DocWidgetModel extends StatelessWidget {
  final DocModel doc;
  const DocWidgetModel({Key? key, required this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (doc.extension == "pdf") {
          final pdfController = PdfController(
            document: PdfDocument.openFile(doc.path),
          );

          Widget pdfView() => PdfView(
                controller: pdfController,
                documentLoader: Center(child: CircularProgressIndicator()),
                pageLoader: Center(child: CircularProgressIndicator()),
              );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pdfView()),
          );
        }
      },
      child: Container(
        width: AppSize.getWidth(context) / 2,
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf_rounded),
            Text(doc.name),
          ],
        ),
      ),
    );
  }
}
