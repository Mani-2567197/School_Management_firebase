import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';

class Editteacher extends StatefulWidget {
  final Teacher teacher;
  const Editteacher({super.key, required this.teacher});

  @override
  _EditteacherState createState() => _EditteacherState();
}

class _EditteacherState extends State<Editteacher> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _employetypeControlller; 

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.teacher.name);
    _emailController = TextEditingController(text: widget.teacher.email);
    _subjectController = TextEditingController(text: widget.teacher.subject);
    _employetypeControlller = TextEditingController(text:widget.teacher.employeementtype);

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  void _updateTeacher() {
    final updatedTeacher = Teacher(
      id: widget.teacher.id,
      name: _nameController.text,
      email: _emailController.text,
      subject: _subjectController.text,
      employeementtype: _employetypeControlller.text,

    );

    Provider.of<TeacherViewModel>(context, listen: false)
        .updateTeacher(updatedTeacher)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Teacher updated successfully!")),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating teacher: $error")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
     final teacherViewModel = Provider.of<TeacherViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Teacher')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                        value: teacherViewModel.seletedsubject,
                        hint: Text('Select Subject'),
                        isExpanded: true,
                       
                        items: teacherViewModel.subject.map((subject){
                          return DropdownMenuItem<String>(value: subject,
                          child:Text(subject),);
                        }).toList(),
                        onChanged: (value) => teacherViewModel.setselctedsubject(value),
                       
                      ),
                      
                      
                      
                      Text('Employeement type:'),
                      Row(
                        children: [
                          Radio<String>(value: 'permanent',
                          groupValue: teacherViewModel.employeementtype,
                          onChanged: (String? value){
                            teacherViewModel.employeementtype =value;
                          },),
                          Text('permanent'),
                          Radio<String>(value: 'contract',
                          groupValue: teacherViewModel.employeementtype,
                          onChanged: (String? value){
                            teacherViewModel.employeementtype =value;
                          },),
                          Text('contract'),
                        ],
                      ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateTeacher,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update Teacher',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
