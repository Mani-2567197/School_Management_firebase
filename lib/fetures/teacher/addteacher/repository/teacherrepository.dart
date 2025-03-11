import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/fetures/teacher/addteacher/model/teacher.dart';

class TeacherRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTeacher(Teacher teacher) async {
    try {
      await _firestore.collection('teachers').doc(teacher.id).set(teacher.toJson());
    } catch (e) {
      print("Error adding teacher: $e");
      throw Exception("Failed to add teacher");
    }
  }

  Future<Teacher?> fetchTeacher(String teacherId) async {
    final doc = await _firestore.collection('teachers').doc(teacherId).get();
    if (doc.exists) {
      return Teacher.fromJson(doc.data()!);
    }
    return null;
  }

  Future<List<Teacher>> fetchAllTeachers(String role) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('teachers').get();
      return querySnapshot.docs.map((doc) => Teacher.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching teachers: $e");
      return [];
    }
  }

  Future<void> deleteTeacher(String teacherId,String userRole) async {
    try {
      await _firestore.collection('teachers').doc(teacherId).delete();
    } catch (e) {
      print("Error deleting teacher: $e");
    }
  }

  Future<void> updateTeacher(Teacher teacher) async {
    try {
      await _firestore.collection('teachers').doc(teacher.id).update(teacher.toJson());
    } catch (e) {
      print("Error updating teacher: $e");
    }
  }
  
  Future<Teacher?> fetchTeacherData(String teacherId) async {
    final doc = await _firestore.collection('teachers').doc(teacherId).get();
    if (doc.exists) {
      return Teacher.fromJson(doc.data()!);
    }
    return null;
  }
}