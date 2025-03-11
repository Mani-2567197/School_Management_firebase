import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';
import 'package:school_management_system/fetures/teacher/addteacher/repository/teacherrepository.dart';
import 'package:school_management_system/routes/routerconstaints.dart';

class TeacherViewModel extends ChangeNotifier {
  final TeacherRepository _repository = TeacherRepository();
  List<Teacher> _teachers = [];
  Teacher? teacher;
  List<Teacher> get teachers => _teachers;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final idController = TextEditingController(); 

  bool isLoading = false;

  Future<void> addTeacher(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final newTeacher = Teacher(
      id: idController.text,
      name: nameController.text,
      email: emailController.text,
      subject: subjectController.text,
    );

    try {
      await _repository.addTeacher(newTeacher);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Teacher added successfully'),
        backgroundColor: Color.fromARGB(255, 130, 155, 131),
      ));
      GoRouter.of(context).go(Routerconstaints.dashboard);
      notifyListeners();
     
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add teacher'),
        backgroundColor: Color.fromARGB(255, 243, 180, 176),
      ));
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> fetchAllTeachers(String s) async {
    try{
    QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection('teachers').get();
    _teachers = querySnapshot.docs.map((doc) => Teacher.fromJson(doc.data() as Map<String,dynamic>)).toList();
    }
    catch(e){
      print("Error :$e");
    }
    notifyListeners();
  }

  Future<void> fetchLoggedInTeacher(String teacherId) async {
    teacher = await _repository.fetchTeacher(teacherId);
    notifyListeners();
  }

  Future<void> deleteTeacher(String teacherId,String userRole) async {
    await _repository.deleteTeacher(teacherId,userRole);
    _teachers.removeWhere((teacher) => teacher.id == teacherId);
    notifyListeners();
  }

  Future<void> updateTeacher(Teacher teacher) async {
    await _repository.updateTeacher(teacher);
    notifyListeners();
  }
}
