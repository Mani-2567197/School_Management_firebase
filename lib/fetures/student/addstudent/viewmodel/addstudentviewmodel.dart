import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/repository/studentrepository.dart';
import 'package:school_management_system/routes/routerconstaints.dart';
import 'package:school_management_system/services/cities.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

class Addstudentviewmodel extends ChangeNotifier {
  final StudentRepository _repository = StudentRepository();
   Student? student;
   List<Student> _students = [];
  List<Student> get students => _students;
  final _city = Cities();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final parentMobileController = TextEditingController();
  final classController = TextEditingController();
  String? selectedCity;
  List<String> cities = [];
  bool isLoading = false;

  Addstudentviewmodel() {
    fetchCities();
  }

  Future<void> fetchCities() async {
    cities = await _city.getCities();
    notifyListeners();
  }

  void setSelectedCity(String? city) {
    selectedCity = city;
    notifyListeners();
  }

  Future<void> addStudent(BuildContext context) async {
    if (!formKey.currentState!.validate() || selectedCity == null) return;
    isLoading = true;
    notifyListeners();

    final student = Student(
      id:idController.text,
      name: nameController.text,
      age: ageController.text,
      email: emailController.text,
      parentMobile: parentMobileController.text,
      studentClass: classController.text,
      city: selectedCity!,
    );

    await _repository.addStudent(student);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student added successfully'),
    backgroundColor: Colorconstaints.successColor,));
    GoRouter.of(context).go(Routerconstaints.dashboard);
    
    isLoading = false;
    notifyListeners();
  }
  Future<void> editStudent(Student student) async {
    await _repository.updateStudent(student);
    notifyListeners();
  }
   Future<void> deleteStudent(String studentId, String userRole) async {
    try {
    if (userRole == 'Admin' || userRole == 'Teacher') {
      await FirebaseFirestore.instance.collection('students').doc(studentId).delete();
      students.removeWhere((student) => student.id == studentId);
      notifyListeners(); 
    }
    /* print('deleted');
     print(studentId);
     print(userRole);  */    
  }
  catch(e){
      print("Error deleting student: $e");
    }
}
  
  Future<void> fetchStudent(String userId) async {
    student = await _repository.fetchStudentData(userId);
    notifyListeners();
  }
   Future<void> fetchAllStudents(String s) async {
    try {
      QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();
       
    _students = querySnapshot.docs.map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<List<String>> getCities() async {
    return await _repository.fetchCities();
  }
}