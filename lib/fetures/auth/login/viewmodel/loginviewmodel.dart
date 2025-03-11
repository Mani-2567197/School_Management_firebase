import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/fetures/auth/login/model/loginmodel.dart';
import 'package:school_management_system/fetures/auth/login/repository/loginrepository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  Future<User?> login(String email, String password) async {
    try {
      return await _loginRepository.signIn(LoginModel(email: email, password: password));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}