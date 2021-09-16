import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:open_file/open_file.dart';
import 'package:revista_way2/model/doc_model.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/send_bloc.dart';

import 'componentes/simple_text_field.dart';
import 'componentes/title_widget.dart';

class SendPage extends StatefulWidget {
  SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  SendBloc bloc = SendBloc();

  var titleController = TextEditingController();
  var authorController = TextEditingController();

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
                  children: const [
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
            customSizedBox(),
            const TitleWidget(
              title: "Título",
            ),
            SimpleTextField(
              hintText: "Escreva o título do seu artigo",
              textEditingController: titleController,
            ),
            customSizedBox(),
            const TitleWidget(
              title: "Autores",
            ),
            SimpleTextField(
              hintText: "Escreva o nome do autor",
              textEditingController: titleController,
            ),
            const ButtonAddAuthor(),
            customSizedBox(),
            const TitleWidget(
              title: "Resumo",
            ),
            SimpleTextField(
              hintText: "Escreva seu resumo",
              textEditingController: authorController,
              isExpand: true,
            ),
            Padding(
                padding: EdgeInsets.only(top: AppSize.defaultPadding / 2),
                child: ButtonAttachDoc(bloc: bloc)),
            StreamBuilder<List<DocModel>>(
              stream: bloc.myStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DocWidgetModel(doc: bloc.docList.first);
                } else {
                  return Center(
                    child: Text(
                      "Anexe seu artigo",
                      style: AppTextStyles.input,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customSizedBox() => SizedBox(height: AppSize.defaultPadding);
}

class ButtonAttachDoc extends StatelessWidget {
  const ButtonAttachDoc({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final SendBloc bloc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        bloc.getDoc();
      },
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

class ButtonAddAuthor extends StatelessWidget {
  const ButtonAddAuthor({
    Key? key,
  }) : super(key: key);

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
    );
  }
}

class DocWidgetModel extends StatelessWidget {
  const DocWidgetModel({Key? key, required this.doc}) : super(key: key);
  final DocModel doc;
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
                documentLoader:
                    const Center(child: CircularProgressIndicator()),
                pageLoader: const Center(child: CircularProgressIndicator()),
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
            const Icon(Icons.picture_as_pdf_rounded),
            Text(doc.name),
          ],
        ),
      ),
    );
  }
}
