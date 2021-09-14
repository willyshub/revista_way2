import 'dart:convert';

import 'package:revista_way2/model/doc_model.dart';

class UserModel {
  String completeName;
  String college;
  String userName;
  UserModel({
    required this.completeName,
    required this.college,
    required this.userName,
  });
// model, view_model, viewm, services utils
  UserModel copyWith({
    String? completeName,
    String? college,
    String? userName,
  }) {
    return UserModel(
      completeName: completeName ?? this.completeName,
      college: college ?? this.college,
      userName: userName ?? this.userName,
    );
  }
}
