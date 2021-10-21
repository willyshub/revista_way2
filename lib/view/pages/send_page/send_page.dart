import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/model/article_model.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/send_vm.dart';
import '../../widgets/title_widget.dart';
import 'componentes/button_add_author_widget.dart';
import 'componentes/button_attach_doc_widget.dart';
import 'componentes/button_submit_article_widget.dart';
import 'componentes/doc_model_widget.dart';
import 'componentes/simple_text_field.dart';

Widget customSizedBox() => SizedBox(height: AppSize.defaultPadding);

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  //
  var titleController = TextEditingController();
  //
  var author1Controller = TextEditingController();
  var author2Controller = TextEditingController();
  var author3Controller = TextEditingController();
  var author4Controller = TextEditingController();
  var author5Controller = TextEditingController();
  //
  var abstractController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late SendVM _sendVMProvider;

  @override
  void initState() {
    super.initState();
    _sendVMProvider = context.read<SendVM>();
    if (_sendVMProvider.listSimpleTextField.isEmpty) {
      // TODO: analisar e tentar melhorar isso
      // inicializa a lista de autores - objetivo: apenas visual.
      initializeListFiled(_sendVMProvider, isInit: true);
    }
  }

  @override
  void didChangeDependencies() {
    _sendVMProvider = context.read<SendVM>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _sendVMProvider.rebootListFild(isInit: true); //
    initializeListFiled(_sendVMProvider, isInit: true);
    _sendVMProvider.deleteDoc(isInit: true);
    super.dispose();
  }

  void initializeListFiled(SendVM providerReadInternal, {bool isInit = false}) {
    providerReadInternal.addSimpleTextField(
      SimpleTextField(
        index: 2,
        hintText: "Ex. Fulano de Tal da Silva Souza",
        textEditingController: author1Controller,
      ),
      isInit: isInit,
    );
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
              //centerTitle: true,
              title: Text(
                "Enviar arquivo",
                overflow: TextOverflow.ellipsis,
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customSizedBox(),
                    const TitleWidget(
                      title: "Título",
                    ),
                    SimpleTextField(
                      index: 1,
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
                          padding: EdgeInsets.only(
                              bottom: AppSize.defaultPadding / 2),
                          child: Text(
                            "$counterAuthor/5",
                            style: AppTextStyles.trailingRegular,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: providerWatch.listSimpleTextField
                          .map<Widget>((simpleTextField) => Column(
                                children: [
                                  simpleTextField,
                                ],
                              ))
                          .toList(),
                    ),
                    Visibility(
                      visible: providerRead.listSimpleTextField.length == 1,
                      replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ButtonAddAuthorWidget(
                              fun: () {
                                final textController = listAuthorController[
                                    providerRead.listSimpleTextField
                                        .length]; // get the first

                                providerRead.addSimpleTextField(
                                  SimpleTextField(
                                    index: 2,
                                    hintText:
                                        "Ex. Fulano de Tal da Silva Souza ${counterAuthor + 1}",
                                    textEditingController: textController,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ButtonAddAuthorWidget(
                              twoButton: true,
                              fun: providerRead.deleteSimpleTextField,
                            ),
                          ),
                        ],
                      ),
                      child: ButtonAddAuthorWidget(
                        fun: () {
                          final textController = listAuthorController[
                              providerRead
                                  .listSimpleTextField.length]; // get the first

                          providerRead.addSimpleTextField(
                            SimpleTextField(
                              index: 2,
                              hintText:
                                  "Ex. Fulano de Tal da Silva Souza ${counterAuthor + 1}",
                              textEditingController: textController,
                            ),
                          );
                        },
                      ),
                    ),
                    customSizedBox(),
                    const TitleWidget(
                      title: "Resumo",
                    ),
                    SimpleTextField(
                      index: 3,
                      hintText: "Escreva seu resumo",
                      textEditingController: abstractController,
                      isExpand: true,
                    ),
                    Consumer<SendVM>(
                      builder: (context, provider, __) {
                        final doc = provider.doc;
                        if (doc == null) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  top: AppSize.defaultPadding / 2),
                              child: ButtonAttachDoc(
                                function: () async {
                                  await provider.getDoc();
                                },
                              ));
                        } else {
                          return DocWidgetModel(
                            doc: doc,
                            funDelete: () {
                              provider.deleteDoc();
                            },
                          );
                        }
                      },
                    ),
                    ButtonSubmitArticleWidget(
                      function: () async {
                        if (_formKey.currentState!.validate()) {
                          final User? user = FirebaseAuth.instance.currentUser;

                          final providerRead = context.read<SendVM>();
                          if (providerRead.listSimpleTextField.isEmpty) {
                            // atribui a ultima modificação do author1Controller a lista Controllers
                            providerRead.addSimpleTextField(
                              SimpleTextField(
                                index: 2,
                                hintText: "Ex. Fulano de Tal da Silva Souza",
                                textEditingController: author1Controller,
                              ),
                            );
                          }

                          //step 1 => transform input in model
                          final articleInstance = Article.fromMap({
                            "title": titleController.text,
                            "userUid": user!.uid,
                            "isApproved": false,
                            "authors": [
                              author1Controller.text,
                              author2Controller.text,
                              author3Controller.text,
                              author4Controller.text,
                              author5Controller.text,
                            ],
                            "abstract": abstractController.text,
                          });

                          //step 2 => send file with name of document

                          await providerRead.uploadDoc(
                            docmodel: providerRead.doc!,
                            context: context,
                            nameArticle: titleController.text,
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          await providerRead
                              .sendArticle(articleInstance); // enviando arquivo
                          if (!mounted) return;
                          customSnackBar(
                              text:
                                  "Artigo enviado com sucesso! Aguarde a aprovação.",
                              context: context);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Campos inválidos",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.buttonBoldHeading,
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }

  void customSnackBar({
    required String text,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green[400],
      content: Text(
        text,
        style: AppTextStyles.buttonBoldHeading,
      ),
    ));
  }
}
