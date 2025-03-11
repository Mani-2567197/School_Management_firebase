import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management_system/fetures/auth/register/model/registrationmodel.dart';

class RegistrationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(RegistrationModel registrationModel) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: registrationModel.email,
        password: registrationModel.password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}