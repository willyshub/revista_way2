import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class Database {
  static String? userID;

  static Future<void> addUser({
    required String nome,
    required int idade,
    required String sobrenome,
  }) async {
    final DocumentReference documentReference = _mainCollection.doc();

    final Map<String, dynamic> data = {
      "nome": nome,
      "idade": idade,
      "sobrenome": sobrenome,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("user added"))
        .catchError((e) => print(e));
  }

  static Future<void> readUsers() async {
    var documentReference = await _mainCollection.get().then((doc) {
      doc.docs.forEach((element) {
        print(element["nome"]);
        print(element["idade"]);
        print(element["sobrenome"]);

      });
    });

    return;
  }
}
