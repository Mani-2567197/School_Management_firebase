import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';
import 'package:school_management_system/fetures/teacher/addteacher/repository/teacherrepository.dart';
import 'package:school_management_system/routes/routerconstaints.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

class TeacherViewModel extends ChangeNotifier {
  final TeacherRepository _repository = TeacherRepository();
  List<Teacher> _teachers = [];
  Teacher? teacher;
  String? seletedsubject;
  String? employeementtype ='permanent';
  List<String> subject =[
    'Maths',
    'Physics',
    'Chemistry',
    'History',
    'Geography',
    'Hindi'
  ];

  List<Teacher> get teachers => _teachers;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final idController = TextEditingController();
  final employetypeControlller =TextEditingController();


  bool isLoading = false;
 TeacherViewModel(){
  seletedsubject = subject.isEmpty? subject[0] :'Maths';
 }
void setselctedsubject(String? sub) {
    seletedsubject = sub;
    notifyListeners();
  }
  Future<void> addTeacher(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final newTeacher = Teacher(
      id: idController.text,
      name: nameController.text,
      email: emailController.text,
      subject: seletedsubject!,
      employeementtype: employeementtype!,
    );

    try {
      await _repository.addTeacher(newTeacher);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Teacher added successfully'),
        backgroundColor: Colorconstaints.successColor
      ));
      GoRouter.of(context).go(Routerconstaints.dashboard);
      notifyListeners();
     
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add teacher'),
        backgroundColor: Colorconstaints.errorColor
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
     // print(s);
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
    fetchAllTeachers(userRole);
    notifyListeners();
  }

  Future<void> updateTeacher(Teacher teacher) async {
    await _repository.updateTeacher(teacher);
    notifyListeners();
  }
}
