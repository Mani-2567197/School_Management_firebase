import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management_system/fetures/auth/login/model/loginmodel.dart';

class LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(LoginModel loginModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}