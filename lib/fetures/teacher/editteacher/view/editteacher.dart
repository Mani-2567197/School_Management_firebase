import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';

class Editteacher extends StatefulWidget {
  final Teacher teacher;
  const Editteacher({ super.key, required this.teacher });

  @override
  _EditteacherState createState() => _EditteacherState();
}

class _EditteacherState extends State<Editteacher> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.teacher.name);
    _emailController = TextEditingController(text: widget.teacher.email);
    _subjectController = TextEditingController(text: widget.teacher.subject);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teacherViewModel = Provider.of<TeacherViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Teacher')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedTeacher = Teacher(
                  id: widget.teacher.id,
                  name: _nameController.text,
                  email: _emailController.text,
                  subject: _subjectController.text,
                );
                await teacherViewModel.updateTeacher(updatedTeacher);
                Navigator.pop(context);
              },
              child: const Text('Update Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}