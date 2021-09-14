import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:revista_way2/model/doc_model.dart';

class Article {
  String title;
  List<String> authors;
  String abstract;
  DocModel doc;
  List<String> ref;
  Article({
    required this.title,
    required this.authors,
    required this.abstract,
    required this.doc,
    required this.ref,
  });

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
}
