import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';

class Addteacher extends StatefulWidget {
  const Addteacher({super.key});

  @override
  _AddteacherState createState() => _AddteacherState();
}

class _AddteacherState extends State<Addteacher> {
  @override
  Widget build(BuildContext context) {
    final teacherViewModel = Provider.of<TeacherViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Teacher')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: teacherViewModel.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Teacher Details",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: teacherViewModel.idController,
                      decoration: const InputDecoration(
                        labelText: 'Teacher ID',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter ID' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: teacherViewModel.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter name' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: teacherViewModel.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter email' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: teacherViewModel.subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter subject' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => teacherViewModel.addTeacher(context),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      child: teacherViewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Add Teacher',),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
