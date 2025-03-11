import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';

class Techerdata extends StatefulWidget {
  final String teacherId;
  const Techerdata({ super.key, required this.teacherId });

  @override
  _TecherdataState createState() => _TecherdataState();
}

class _TecherdataState extends State<Techerdata> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TeacherViewModel>(context, listen: false)
          .fetchLoggedInTeacher(widget.teacherId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final teacherViewModel = Provider.of<TeacherViewModel>(context);
    final teacher = teacherViewModel.teacher; 
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Profile')),
      body: teacher == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Id: ${teacher.id}', style: const TextStyle(fontSize: 18)),
                  Text('Name: ${teacher.name}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Email: ${teacher.email}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Subject: ${teacher.subject}', style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
    );
  }
}