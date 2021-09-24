import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:revista_way2/model/doc_model.dart';

class Article {
  Article({
    required this.title,
    required this.authors,
    required this.abstract,
    required this.doc,
    required this.ref,
  });

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      authors: List<String>.from(map['authors'] as List<String>),
      abstract: map['abstract'] as String,
      doc: DocModel.fromMap(map['doc'] as Map<String, dynamic>),
      ref: List<String>.from(map['ref'] as List<String>),
    );
  }

  String title;
  List<String> authors;
  String abstract;
  DocModel doc;
  List<String> ref;

  Article copyWith({
    String? title,
    List<String>? authors,
    String? abstract,
    DocModel? doc,
    List<String>? ref,
  }) {
    return Article(
      title: title ?? this.title,
      authors: authors ?? this.authors,
      abstract: abstract ?? this.abstract,
      doc: doc ?? this.doc,
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'authors': authors,
      'abstract': abstract,
      'doc': doc.toMap(),
      'ref': ref,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Article(title: $title, authors: $authors, abstract: $abstract, doc: $doc, ref: $ref)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.title == title &&
        listEquals(other.authors, authors) &&
        other.abstract == abstract &&
        other.doc == doc &&
        listEquals(other.ref, ref);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        authors.hashCode ^
        abstract.hashCode ^
        doc.hashCode ^
        ref.hashCode;
  }
}
