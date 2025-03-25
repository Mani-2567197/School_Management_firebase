import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';
import 'package:school_management_system/fetures/teacher/editteacher/view/editteacher.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

class Getallteachers extends StatefulWidget {
  const Getallteachers({ super.key });

  @override
  _GetallteachersState createState() => _GetallteachersState();
}

class _GetallteachersState extends State<Getallteachers> {
   String? userRole;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        userRole = userDoc['role'];
      });

      if (userRole == 'Admin') {
        Provider.of<TeacherViewModel>(context, listen: false).fetchAllTeachers(userRole!);
      }
    }
  }
  void _confirmDelete(BuildContext context,String teacherId){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Confirm Delete"),
      content:  const Text("Are u sure u want to remove the teacher?"),
      actions: [
        TextButton(onPressed: (){
          Provider.of<TeacherViewModel>(context, listen: false).deleteTeacher(teacherId, 'Admin');
          Navigator.pop(context);
        },
        child: const Text("Delete",style: TextStyle(color: Colorconstaints.errorColor),))
      ],
    ),);
  }
  void _editTeacher(BuildContext context, Teacher teacher) {
  if (userRole == 'Admin') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Editteacher( teacher: teacher,),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Only Admin can edit Teachers data.")),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    final teacherViewModel = Provider.of<TeacherViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('All Teachers')),
      body: userRole == null
          ? const Center(child: CircularProgressIndicator())
          : userRole != 'Admin'
              ? const Center(child: Text('Access Denied'))
                 : teacherViewModel.teachers.isEmpty
                  ? const Center(child: Text('No teachers found.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DataTable(
                            columnSpacing: 30, 
                            columns: [
                              DataColumn(label: Text('Tecaher ID',style:Theme.of(context).textTheme.titleLarge)),
                              DataColumn(label: Text('Techer Name',style:Theme.of(context).textTheme.titleLarge)),
                              DataColumn(label: Text('Email',style:Theme.of(context).textTheme.titleLarge)),
                              DataColumn(label: Text('Subject',style:Theme.of(context).textTheme.titleLarge)),
                              DataColumn(label: Text('Edit',style:Theme.of(context).textTheme.titleLarge)),
                              DataColumn(label: Text('Delete',style:Theme.of(context).textTheme.titleLarge))
                            ],
                            rows: teacherViewModel.teachers.map(
                                  (teacher) => DataRow(cells: [
                                    DataCell(Text(teacher.id,style:Theme.of(context).textTheme.bodyLarge)),
                                    DataCell(Text(teacher.name,style:Theme.of(context).textTheme.bodyLarge)),
                                    DataCell(Text(teacher.email,style:Theme.of(context).textTheme.bodyLarge)),
                                    DataCell(Text(teacher.subject,style:Theme.of(context).textTheme.bodyLarge)),
                                    DataCell(
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colorconstaints.secondaryColor),
                                  onPressed: () => _editTeacher(context, teacher),
                                ),
                              ),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colorconstaints.errorColor),
                                        onPressed: () =>
                                            _confirmDelete(context, teacher.id),
                                      ),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
    );
  }
}