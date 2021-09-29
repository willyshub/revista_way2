import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Article {
  Article({
    this.id,
    required this.userUid,
    required this.title,
    required this.authors,
    required this.abstract,
    required this.ref,
    //required this.doc,
  });

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title']! as String,
      userUid: map['userUid']! as String,
      authors: List<String>.from(map['authors']! as List<String>),
      abstract: map['abstract'] as String,
      // doc: DocModel.fromMap(map['doc'] as Map<String, dynamic>),
      ref: List<String>.from(map['ref']! as List<String>),
    );
  }

  factory Article.fromDocument(DocumentSnapshot document) {
    return Article(
      id: document.id,
      userUid: document['userUid'] as String,
      title: document['title'] as String,
      authors: List<String>.from(document['authors'] as List<dynamic>),
      abstract: document['abstract'] as String,
      //doc: DocModel.fromMap(document['doc'] as Map<String, dynamic>),
      ref: List<String>.from(document['ref'] as List<dynamic>),
    );
  }

  String? id;
  String title;
  String? userUid;
  List<String> authors;
  String abstract;
  List<String> ref;
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
      'userUid': userUid,
      'authors': authors,
      'abstract': abstract,
      'ref': ref,
      //'doc': doc.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Article(title: $title, authors: $authors, abstract: $abstract,  ref: $ref)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.title == title &&
        listEquals(other.authors, authors) &&
        other.abstract == abstract &&
        //other.doc == doc &&
        listEquals(other.ref, ref);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        authors.hashCode ^
        abstract.hashCode ^
        //doc.hashCode ^
        ref.hashCode;
  }
}
