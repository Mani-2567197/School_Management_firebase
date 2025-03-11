import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';
import 'package:school_management_system/fetures/student/editstudent/view/editstudent.dart';

class GetAllStudents extends StatefulWidget {
  const GetAllStudents({super.key});

  @override
  _GetAllStudentsState createState() => _GetAllStudentsState();
}

class _GetAllStudentsState extends State<GetAllStudents> {
  String? userRole;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // print("User ID: ${user.uid}");
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();      
      setState(() {
        userRole = userDoc['role'];
      });
     // print(userRole);
      if (userRole == 'Admin' || userRole == 'Teacher') {
       // print("fetching students");
        Provider.of<Addstudentviewmodel>(context, listen: false).fetchAllStudents(userRole!);
      }
      else{
        print(userRole);
        print(
          "i am not admin or teacher"
        );
      }
    }
    
  }
  void _editStudent(BuildContext context, Student student) {
  if (userRole == 'Admin') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Editstudent(student: student),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Only Admin can edit students")),
    );
  }
}
  void _confirmDelete(BuildContext context, String studentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to remove this student?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (userRole == 'Admin' || userRole == 'Teacher') {
                Provider.of<Addstudentviewmodel>(context, listen: false)
                    .deleteStudent(studentId, userRole!);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Permission Denied")),
                );
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Students')),
      body: userRole == null
          ? const Center(child: CircularProgressIndicator())
          : userRole != 'Admin' && userRole != 'Teacher'
              ? const Center(child: Text('Access Denied'))
              : Consumer<Addstudentviewmodel>(
                  builder: (context, studentViewModel, child) {
                    if (studentViewModel.students.isEmpty) {
                      return const Center(child: Text('No students found.'));
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 30, 
                        columns: const [
                          DataColumn(label: Text('Id')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Age')),
                          DataColumn(label: Text('Class')),
                          DataColumn(label: Text('City')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Parent Mobile')),
                          DataColumn(label: Text('Edit')),
                          DataColumn(label: Text('Delete'))
                        ],
                        rows: studentViewModel.students.map((student) {
                          return DataRow(
                            cells: [
                              DataCell(Text(student.id)),
                              DataCell(Text(student.name)),
                              DataCell(Text(student.age)),
                              DataCell(Text(student.studentClass)),
                              DataCell(Text(student.city)),
                              DataCell(Text(student.email)),
                              DataCell(Text(student.parentMobile)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.amber),
                                  onPressed: () => _editStudent(context, student),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDelete(context, student.id),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
