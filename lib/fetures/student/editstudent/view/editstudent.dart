import 'package:flutter/material.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';

class Editstudent extends StatefulWidget {
  final Student student;
  const Editstudent({super.key, required this.student});

  @override
  _EditstudentState createState() => _EditstudentState();
}

class _EditstudentState extends State<Editstudent> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late TextEditingController parentMobileController;
  late TextEditingController studentClassController;
  String? selectedCity;
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age);
    emailController = TextEditingController(text: widget.student.email);
    parentMobileController = TextEditingController(
      text: widget.student.parentMobile,
    );
    studentClassController = TextEditingController(
      text: widget.student.studentClass,
    );
    selectedCity = widget.student.city;
    _fetchCities();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    parentMobileController.dispose();
    studentClassController.dispose();
    super.dispose();
  }

  Future<void> _fetchCities() async {
    final viewModel = Addstudentviewmodel();
    final fetchedCities = await viewModel.getCities();
    setState(() {
      cities = fetchedCities.toSet().toList();
      if (!cities.contains(selectedCity)) {
        selectedCity = null;
      }
    });
  }

  Future<void> _editStudent() async {
    final updatedStudent = Student(
      id: widget.student.id,
      name: nameController.text,
      age: ageController.text,
      email: emailController.text,
      parentMobile: parentMobileController.text,
      studentClass: studentClassController.text,
      city: selectedCity!,
    );

    final viewModel = Addstudentviewmodel();
    await viewModel.editStudent(updatedStudent);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student details updated successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Student')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: parentMobileController,
                      decoration: const InputDecoration(
                        labelText: 'Parent Mobile',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: studentClassController,
                      decoration: const InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value:
                          cities.contains(selectedCity) ? selectedCity : null,
                      decoration: const InputDecoration(
                        labelText: 'Select City',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          cities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                      onChanged: (value) {
                        // print("City changed to: $value");
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _editStudent,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
