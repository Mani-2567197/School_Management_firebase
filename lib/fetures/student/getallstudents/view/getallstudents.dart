import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';
import 'package:school_management_system/fetures/student/editstudent/view/editstudent.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

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
            child: const Text("Delete", style: TextStyle(color:Colorconstaints.errorColor)),
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
                        columns: [
                          DataColumn(label: Text('Id',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Name',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Age',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Class',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('City',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Email',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Parent Mobile',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Edit',style:Theme.of(context).textTheme.titleLarge)),
                          DataColumn(label: Text('Delete',style:Theme.of(context).textTheme.titleLarge))
                        ],
                        rows: studentViewModel.students.map((student) {
                          return DataRow(
                            cells: [
                              DataCell(Text(student.id,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.name,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.age,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.studentClass,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.city,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.email,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(Text(student.parentMobile,style:Theme.of(context).textTheme.bodyLarge)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colorconstaints.secondaryColor),
                                  onPressed: () => _editStudent(context, student),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colorconstaints.errorColor),
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
