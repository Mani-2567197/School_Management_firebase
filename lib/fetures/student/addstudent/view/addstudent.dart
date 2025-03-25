import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';
import 'package:school_management_system/utils/colorconstaints.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({ super.key });

  @override
  _AddstudentState createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
    @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<Addstudentviewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: viewModel.formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildTextField(viewModel.idController, 'Id'),
                    _buildTextField(viewModel.nameController, 'Name'),
                    _buildTextField(viewModel.ageController, 'Age', isNumber: true),
                    _buildTextField(viewModel.emailController, 'Email'),
                    _buildTextField(viewModel.parentMobileController, 'Parent Mobile', isNumber: true),
                    _buildTextField(viewModel.classController, 'Class'),
                    
                    DropdownButtonFormField<String>(
                      value: viewModel.selectedCity,
                      hint: Text('Select City'),
                      items: viewModel.cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                      onChanged: (value) => viewModel.setSelectedCity(value),
                      validator: (value) => value == null ? 'Select a city' : null,
                    ),
        
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: viewModel.isLoading ? null : () => viewModel.addStudent(context),
                      child: viewModel.isLoading ? CircularProgressIndicator(color: Colorconstaints.backgroundColor) : Text('Add Student'),
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

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) => value!.isEmpty ? 'Enter $label' : null,
    );
}
}
