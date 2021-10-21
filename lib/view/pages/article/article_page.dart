import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revista_way2/view-model/auth/auth_firebase.dart';
import '/exports/my_classes.dart';
import 'components/button_icon_text.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  /* Future<void> downloadPdfURL() async {
    final storage = FirebaseStorage.instance;

    //final nameFile = 'articles_pdfs/pdf-${article.userUid}.pdf';
    final downloadURL = await storage
        .ref("articles_pdfs/pdf-taEgxI6UaNgR4Z1LUgTnWsfv9wz2.pdf")
        .getDownloadURL();
    final uri = Uri.parse(downloadURL);
    // Dio dio = dio.downloadUri(uri, savePath);
  } */

  Future<String> getUrlDonwload() async {
    final storage = FirebaseStorage.instance;
    final downloadURL = await storage
        .ref(
            "articles_pdfs/pdf-${widget.article.id}-${widget.article.userUid}.pdf")
        .getDownloadURL();
    return downloadURL;
  }

  Future<File> createFileOfPdfUrl(String url) async {
    // NomeModelo do pdf no firebase
    //pdf-(idArtigo)-(uid).pdf
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

    await Share.share(
      file.path,
      subject: file.path,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  File file = File('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrlDonwload().then((url) {
      createFileOfPdfUrl(url).then((f) {
        setState(() {
          file = f;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
              centerTitle: true,
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
                                    text: "Cadastre-se para ler.",
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
                                if (file.path == '') {
                                  if (!mounted) return;
                                  debugPrint("Path do pdf: ${file.path}");
                                  customSnackBar(
                                      context: context,
                                      text:
                                          "Não foi possível compartilhar. Tente novamente.");
                                } else {
                                  debugPrint("Path do pdf: ${file.path}");
                                  await _onShare();
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

/* 
  ------------------------------------------------------

                        DEAD CODES 

  ------------------------------------------------------

 */

/* class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
} */

/*  SizedBox(
                        height: AppSize.defaultPadding,
                      ),
                      Text(
                        "Referências: ",
                        style: AppTextStyles.buttonBoldHeading,
                      ),
                      Column(
                        children: article.ref
                            .map(
                              (name) => Text(
                                name,
                                style: AppTextStyles.buttonGray,
                              ),
                            )
                            .toList(),
                      ), */

// floatingActionButton: FloatingActionButton(
//   onPressed: () {},
//   backgroundColor: AppColors.primary,
//   child: IconButton(
//     onPressed: () {},
//     icon: const Icon(Icons.download_rounded),
//   ),
// ),


/* final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    var bodyBytes = downloadData.bodyBytes;
    final String name = await ref.getName();
    final String path = await ref.getPath();  */