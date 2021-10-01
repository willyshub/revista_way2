import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  Article({
    this.id,
    required this.userUid,
    required this.title,
    this.isApproved = false,
    required this.authors,
    required this.abstract,

    //required this.doc,
  });

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Article.fromMap(Map<String, dynamic> map, {bool hasId = false}) {
    if (hasId) {
      return Article(
        id: map['id'] as String,
        isApproved: map['isApproved'] as bool,
        title: map['title']! as String,
        userUid: map['userUid']! as String,
        authors: List<String>.from(map['authors']! as List<String>),
        abstract: map['abstract'] as String,
      );
    } else {
      return Article(
        title: map['title']! as String,
        isApproved: map['isApproved'] as bool,
        userUid: map['userUid']! as String,
        authors: List<String>.from(map['authors']! as List<String>),
        abstract: map['abstract'] as String,
      );
    }
  }

  factory Article.fromDocument(DocumentSnapshot document) {
    return Article(
      id: document.id,
      userUid: document['userUid'] as String,
      isApproved: document['isApproved'] as bool,
      title: document['title'] as String,
      authors: List<String>.from(document['authors'] as List<dynamic>),
      abstract: document['abstract'] as String,
    );
  }

  String? id;
  String title;
  String userUid;
  bool isApproved;
  List<String> authors;
  String abstract;

  //DocModel doc;

  /*  Article copyWith({
    String? title,
    String? id,
    List<String>? authors,
    String? abstract,
    DocModel? doc,
    List<String>? ref,
  }) {
    return Article(
      id: id,
      userUid: userUid,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      abstract: abstract ?? this.abstract,
      //doc: doc ?? this.doc,
      ref: ref ?? this.ref,
    );
  } */

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      "isApproved": isApproved,
      'userUid': userUid,
      'authors': authors,
      'abstract': abstract,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Article(title: $title, authors: $authors, abstract: $abstract,)';
  }
}
