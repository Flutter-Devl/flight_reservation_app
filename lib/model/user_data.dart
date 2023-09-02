import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String username = 'Username';
  String? email;
  String? password;

  void setEmailAndPassword(String email, String password) {
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  void saveProfileChanges({
    required String username,
    required String email,
    required String password,
  }) {
    this.username = username;
    this.email = email;
    this.password = password;
    notifyListeners();
  }
}
