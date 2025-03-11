import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/fetures/auth/register/model/registrationmodel.dart';
import 'package:school_management_system/fetures/auth/register/repository/registrationrepository.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationRepository _registrationRepository = RegistrationRepository();

  Future<User?> register(String email, String password) async {
    try {
      return await _registrationRepository.signUp(RegistrationModel(email: email, password: password));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}