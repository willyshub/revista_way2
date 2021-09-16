import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:revista_way2/model/doc_model.dart';

class SendBloc {
  final _blocController = StreamController<List<DocModel>>();

  List<DocModel> _docList = [];

  List<DocModel> get docList => _docList;

  Stream<List<DocModel>> get myStream => _blocController.stream;

  void addDocList(DocModel doc) {
    _docList.add(doc);
    _blocController.sink.add(docList);
  }

  void closeStream() {
    _blocController.close();
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

      addDocList(doc);

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
}
