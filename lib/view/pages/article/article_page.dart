import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revista_way2/view-model/auth/auth_firebase.dart';
import 'package:share_plus/share_plus.dart';
import '/exports/my_classes.dart';
import 'components/button_icon_text.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  String? _urlDonwload;
  File? _pdfArticle;

  Future<String> getUrlDonwload() async {
    final storage = FirebaseStorage.instance;
    final ref =
        "articles_pdfs/pdf-${widget.article.id}-${widget.article.userUid}.pdf";
    final downloadURL = await storage.ref(ref).getDownloadURL();
    return downloadURL;
  }

  Future<File> createFileOfPdfUrl(String url) async {
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File file =
        File('$dir/pdf-${widget.article.id}${widget.article.userUid}.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> _onShare() async {
    final box = context.findRenderObject() as RenderBox?;
    final fileInternal = _pdfArticle!;
    await Share.shareFiles(
      [fileInternal.path],
      subject: "by RevistaWay: ${widget.article.title}",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  File file = File('');

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    getUrlDonwload().then((url) {
      _urlDonwload = url;
      createFileOfPdfUrl(url).then((pdf) {
        _pdfArticle = pdf;
        setState(() {
          file = pdf;
        });
      });
    });
  }

  @override
  void didUpdateWidget(covariant ArticlePage oldWidget) {
    getUrlDonwload().then((url) {
      createFileOfPdfUrl(url).then((f) {
        setState(() {
          file = f;
        });
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primary,
            toolbarHeight: 60,
            expandedHeight: 100.0,
            collapsedHeight: 60.0,
            floating: true,
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
                "Artigo",
                style: AppTextStyles.titleRegular,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.defaultPadding,
                    vertical: AppSize.defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: widget.article.title,
                      ),
                      const Divider(),
                      Text(
                        widget.article.abstract,
                        style: AppTextStyles.trailingRegular,
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppSize.defaultPadding / 3,
                        ),
                        child: Row(
                          children: [
                            ButtonIconTextWidget(
                              icon: Icons.menu_book_rounded,
                              text: "LER",
                              function: () async {
                                final user = await AuthFirebase.currentUser();
                                if (user == null) {
                                  if (!mounted) return;
                                  customSnackBar(
                                    context: context,
                                    text: "Cadastre-se para LER! É rápido.",
                                  );
                                } else {
                                  if (file.path == '') {
                                    debugPrint("Path do pdf: ${file.path}");
                                    if (!mounted) return;
                                    customSnackBar(
                                        context: context,
                                        text:
                                            "Não foi possível baixar e abrir. Tente novamente.");
                                  } else {
                                    final pdfController = PdfController(
                                      document: PdfDocument.openFile(file.path),
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
                                    if (!mounted) return;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => pdfView(),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              width: AppSize.defaultPadding / 3,
                            ),
                            /* ButtonIconTextWidget(
                              icon: Icons.download_rounded,
                              text: "BAIXAR",
                              function: () async {},
                            ), */
                            SizedBox(
                              width: AppSize.defaultPadding / 3,
                            ),
                            ButtonIconTextWidget(
                              icon: Icons.share_outlined,
                              text: "COMPARTILHAR",
                              function: () async {
                                final user = await AuthFirebase.currentUser();
                                if (user == null) {
                                  customSnackBar(
                                    context: context,
                                    text:
                                        "Cadastre-se para COMPARTILHAR! É rápido.",
                                  );
                                } else {
                                  if (!mounted) return;
                                  if (file.path == '') {
                                    debugPrint("Path do pdf: ${file.path}");
                                    customSnackBar(
                                        context: context,
                                        text:
                                            "Não foi possível compartilhar. Tente novamente.");
                                  } else {
                                    debugPrint("Path do pdf: ${file.path}");
                                    await _onShare();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.defaultPadding,
                      ),
                      Text(
                        "Autores: ",
                        style: AppTextStyles.buttonBoldHeading,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.article.authors
                            .map(
                              (name) => Text(
                                name,
                                style: AppTextStyles.buttonGray,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void customSnackBar({
    required String text,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red[400],
      content: Text(
        text,
        style: AppTextStyles.buttonBoldHeading,
      ),
    ));
  }
}
