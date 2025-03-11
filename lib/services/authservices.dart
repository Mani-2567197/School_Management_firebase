import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;
  
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
  Future<String?> getUserRole() async {
    if (currentUser == null) return null;

    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(currentUser!.uid).get();
    
    return userDoc.exists ? userDoc['role'] : null;
  }
  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
