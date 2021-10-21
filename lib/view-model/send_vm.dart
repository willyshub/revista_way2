import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/exports/my_classes.dart';
import 'package:revista_way2/model/doc_model.dart';
import 'package:revista_way2/view-model/auth/auth_firebase.dart';
import 'package:revista_way2/view/pages/send_page/componentes/simple_text_field.dart';

class SendVM extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  /* [DOC VIEW-MODEL] */

  DocModel? doc;

  void setDoc(DocModel docInternal) {
    doc = docInternal;
    notifyListeners();
  }

  void deleteDoc() {
    doc = null;
    notifyListeners();
  }

  Future<void> uploadDoc({
    required DocModel docmodel,
    required BuildContext context,
    required String nameArticle,
  }) async {
    final file = File(docmodel.path!);
    final User? user = FirebaseAuth.instance.currentUser;
    Provider.of<AuthFirebase>(context, listen: false);
    try {
      final ref =
          'articles_docs/doc-$nameArticle-${user!.uid}.${docmodel.typeFile}';
      _storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception("Error no upload: ${e.code}");
    }
  }

  Future<void> sendArticle(Article article) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    _firestore
        .collection('articles_peding')
        .add(article.toMap())
        .whenComplete(() => debugPrint("article was sent"))
        .catchError((e) => debugPrint(e.toString()));
  }

  Future<DocModel> getDoc() async {
    //await Future.delayed(Duration(seconds: 10));
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', "docx"],
      allowCompression: false,
    );

    if (result != null) {
      final PlatformFile file = result.files.first;

      final DocModel doc = DocModel.fromMap(
        {
          "size": file.size,
          "name": file.name,
          "typeFile": file.extension,
          "path": file.path,
          "file": File(file.path!)
        },
      );

      setDoc(doc);

      return doc;
    } else {
      // User canceled the picker
      final DocModel doc = DocModel.fromMap({
        "size": null,
        "name": null,
        "extension": null,
        "path": null,
      });

      return doc;
    }
  }

  //
  //      LISTAS AUTORES-
  //

  List<SimpleTextField> listSimpleTextField = [];

  void addSimpleTextField(SimpleTextField value) {
    final length = listSimpleTextField.length;
    if (length < 5) {
      listSimpleTextField.add(value);
      notifyListeners();
    }
  }

  void rebootListFild() {
    listSimpleTextField = [];
    notifyListeners();
  }

  void deleteSimpleTextField() {
    listSimpleTextField.remove(listSimpleTextField.last);
    notifyListeners();
  }
}
