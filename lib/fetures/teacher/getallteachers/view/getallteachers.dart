import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';

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
        child: const Text("Delete",style: TextStyle(color: Colors.red),))
      ],
    ),);
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
                            columns: const [
                              DataColumn(label: Text('Tecaher ID')),
                              DataColumn(label: Text('Techer Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Subject')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: teacherViewModel.teachers.map(
                                  (teacher) => DataRow(cells: [
                                    DataCell(Text(teacher.id)),
                                    DataCell(Text(teacher.name)),
                                    DataCell(Text(teacher.email)),
                                    DataCell(Text(teacher.subject)),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
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