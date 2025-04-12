import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: teacherViewModel.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      ElevatedButton(
                        onPressed: () => teacherViewModel.addTeacher(context),
                        child: teacherViewModel.isLoading ? CircularProgressIndicator(color: Colorconstaints.backgroundColor) : Text('Add Teacher'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
