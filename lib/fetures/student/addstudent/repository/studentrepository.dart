import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';


class StudentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Dio _dio = Dio();
  Future<void> addStudent(Student student) async {
    await _firestore.collection('students').doc(student.id).set(student.toJson());
  }

  Future<List<Student>> getStudents(String role) async {
    try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();

    return querySnapshot.docs
        .map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print("Error fetching students: $e");
    return [];
  }
  }

  Future<void> deleteStudent(String studentId, String userRole) async {
    try {
      await _firestore.collection('students').doc(studentId).delete();
    } catch (e) {
      throw Exception("Failed to delete student: $e");
    }
  }
  Future<void> updateStudent(Student student) async {
    await _firestore.collection('students').doc(student.id).update(student.toJson());
  }
  Future<Student?> fetchStudentData(String userId) async {
    final doc = await _firestore.collection('students').doc(userId).get();
    if (doc.exists) {
      return Student.fromJson(doc.data()!);
    }
    return null;
  }
  Future<List<String>> fetchCities() async {
    final response = await _dio.get('https://67b5afbb07ba6e59083dfde3.mockapi.io/school/City');
    if (response.statusCode == 200) {
      return List<String>.from(response.data.map((city) => city['name']));
    } else {
      throw Exception('Failed to fetch cities');
    }
  }
  


}
