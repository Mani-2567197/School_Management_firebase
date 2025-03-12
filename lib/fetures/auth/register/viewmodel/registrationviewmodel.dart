import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/auth/register/repository/registrationrepository.dart';
import 'package:school_management_system/routes/routerconstaints.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationRepository _registrationRepository = RegistrationRepository();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Student';
  bool isLoading = false;

  void setRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _registrationRepository.registerUser(
        emailController.text,
        passwordController.text,
        selectedRole,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful!',style: TextStyle(color: Colors.greenAccent),)),
      );
     GoRouter.of(context).go(Routerconstaints.login);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}