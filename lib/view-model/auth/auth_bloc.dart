import 'package:flutter/material.dart';
import 'package:revista_way2/model/user_model.dart';


class AuthBloc {
  bool _isAuthenticated = false;
  UserModel? _user;
  UserModel? get user => _user;

  void setUser(BuildContext context, UserModel? userLocal) {}

  Future<void> currentUser(BuildContext context) async {
    context.toString();
    return;
  }
}
