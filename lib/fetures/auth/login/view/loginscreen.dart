import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/auth/register/view/registrationscreen.dart';
import 'package:school_management_system/routes/routerconstaints.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Student';

   void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (userDoc.exists && userDoc['role'] == selectedRole) {
        GoRouter.of(context).go(Routerconstaints.dashboard);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Role mismatch or user not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: ['Admin', 'Teacher', 'Student']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: login, child: Text('Login')),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
