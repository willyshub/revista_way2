import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:revista_way2/exports/my_classes.dart';
import 'package:revista_way2/model/doc_model.dart';
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

  Future<DocModel> getDoc() async {
    //await Future.delayed(Duration(seconds: 10));
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: false,
    );

    if (result != null) {
      final PlatformFile file = result.files.first;

      final DocModel doc = DocModel.fromMap({
        "size": file.size,
        "name": file.name,
        "extension": file.extension,
        "path": file.path,
      });

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
      debugPrint("length: $length");
      notifyListeners();
    }
  }

  void deleteSimpleTextField(SimpleTextField value) {
    listSimpleTextField.remove(listSimpleTextField.last);
    notifyListeners();
  }
}
