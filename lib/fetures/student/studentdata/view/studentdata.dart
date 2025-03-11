import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';

class Studentdata extends StatefulWidget {
  const Studentdata({ super.key });

  @override
  _StudentdataState createState() => _StudentdataState();
}

class _StudentdataState extends State<Studentdata> {
  Addstudentviewmodel studentViewModel = Addstudentviewmodel();
  Student? student;
   @override
  void initState() {
    super.initState();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await studentViewModel.fetchStudent(user.uid);
      setState(() {
        student = studentViewModel.student;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: student == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${student!.name}', style: const TextStyle(fontSize: 18)),
                  Text('Email: ${student!.email}', style: const TextStyle(fontSize: 18)),
                  Text('Parent Mobile: ${student!.parentMobile}', style: const TextStyle(fontSize: 18)),
                  Text('Class: ${student!.studentClass}', style: const TextStyle(fontSize: 18)),
                  Text('City: ${student!.city}', style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
    );
  }
}