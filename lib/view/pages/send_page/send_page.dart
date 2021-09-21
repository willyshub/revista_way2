import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/send_vm.dart';
import '../../widgets/title_widget.dart';
import 'componentes/button_add_author_widget.dart';
import 'componentes/button_attach_doc_widget.dart';
import 'componentes/doc_model_widget.dart';
import 'componentes/simple_text_field.dart';

Widget customSizedBox() => SizedBox(height: AppSize.defaultPadding);

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  var titleController = TextEditingController();
  var author1Controller = TextEditingController();
  var author2Controller = TextEditingController();
  var author3Controller = TextEditingController();
  var author4Controller = TextEditingController();
  var author5Controller = TextEditingController();
  var abstractController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final providerRead = context.read<SendVM>();
    if (providerRead.listSimpleTextField.isEmpty) {
      providerRead.addSimpleTextField(
        SimpleTextField(
          hintText: "Escreva o nome do autor",
          textEditingController: author1Controller,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerRead = context.read<SendVM>();
    final providerWatch = context.watch<SendVM>();
    final counterAuthor = providerWatch.listSimpleTextField.length;

    final List<TextEditingController> listAuthorController = [
      author1Controller,
      author2Controller,
      author3Controller,
      author4Controller,
      author5Controller,
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            centerTitle: true,
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Enviar arquivo",
                style: AppTextStyles.titleRegular,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPadding,
                vertical: AppSize.defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // titulo
                  customSizedBox(),
                  const TitleWidget(
                    title: "Título",
                  ),
                  SimpleTextField(
                    hintText: "Escreva o título do seu artigo",
                    textEditingController: titleController,
                  ),
                  // autores
                  customSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleWidget(
                        title: "Autores",
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: AppSize.defaultPadding / 2),
                        child: Text(
                          "$counterAuthor/5",
                          style: AppTextStyles.trailingRegular,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: providerWatch.listSimpleTextField
                        .map<Widget>((simpleTextField) => simpleTextField)
                        .toList(),
                  ),

                  ButtonAddAuthorWidget(
                    fun: () {
                      final textController = listAuthorController[providerRead
                          .listSimpleTextField.length]; // get the first

                      providerRead.addSimpleTextField(
                        SimpleTextField(
                          hintText:
                              "Escreva o nome do autor ${counterAuthor + 1}",
                          textEditingController: textController,
                        ),
                      );
                    },
                  ),
                  // resumo
                  customSizedBox(),
                  const TitleWidget(
                    title: "Resumo",
                  ),
                  SimpleTextField(
                    hintText: "Escreva seu resumo",
                    textEditingController: abstractController,
                    isExpand: true,
                  ),
                  Consumer<SendVM>(builder: (context, provider, __) {
                    final doc = provider.doc;
                    if (doc == null) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: AppSize.defaultPadding / 2),
                        child: ButtonAttachDoc(
                          function: () async {
                            await provider.getDoc();
                          },
                        ),
                      );
                    } else {
                      return DocWidgetModel(
                        doc: doc,
                        funDelete: () {
                          provider.deleteDoc();
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ])),
        ],
      ),
    );
  }
}




/*
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, bool a) {
            return [
              SliverAppBar(
                centerTitle: true,
                brightness: Brightness.dark,
                backgroundColor: AppColors.primary,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleWidget(
                    title: "Autores",
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: AppSize.defaultPadding / 2),
                    child: Text(
                      "Add new",
                      style: AppTextStyles.trailingRegular,
                    ),
                  ),
                ],
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
              StreamBuilder<List<DocModel>>(
                stream: bloc.myStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DocWidgetModel(doc: bloc.docList.first);
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: AppSize.defaultPadding / 2),
                      child: ButtonAttachDoc(bloc: bloc),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    */
