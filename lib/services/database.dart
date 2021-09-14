import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');


class Database {
  static String? userID;

  static addUser({
    required String nome,
    required int idade,
    required String sobrenome,
  }) async {
    final DocumentReference documentReference =
        _mainCollection.doc(userID).collection('users').doc();

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

  static Stream<DocumentSnapshot> readUsers() {
    final DocumentReference documentReference = _mainCollection.doc(userID);

    return documentReference.snapshots();
  }
}
