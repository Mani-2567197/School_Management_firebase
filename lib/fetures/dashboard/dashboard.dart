import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/routes/routerconstaints.dart';
import 'package:school_management_system/utils/themeprovider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key, required String role });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool isMenuOpen = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  void removeUser(String userId, String role) async {
    await FirebaseFirestore.instance.collection('${role.toLowerCase()}s').doc(userId).delete();
  }

  Widget buildMenuButton() {
    return IconButton(
      icon: Icon(isMenuOpen ? Icons.close : Icons.menu, color: Colors.white),
      onPressed: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
    );
  }

  Widget buildAdminMenu() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add Teacher'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.addteacher),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('All Teachers'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.manageteachers),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('All Students'),
            onTap: () => GoRouter.of(context).push( Routerconstaints.removestudent),
          ),
          ListTile(
            leading: Icon(Icons.person_remove),
            title: Text('remove students'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.removestudent),
          ),
           ListTile(
            leading: Icon(Icons.person_remove),
            title: Text('remove teachers'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.manageteachers),
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt),
            title: Text('Add Student'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.addstudent),
          ),
        ],
      ),
    );
  }

  Widget buildTeacherMenu() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.group),
            title: Text('All Students'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.removestudent),
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt),
            title: Text('Add Students'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.removestudent),
          ),
          ListTile(
            leading: Icon(Icons.person_remove),
            title: Text('remove Students'),
            onTap: () => GoRouter.of(context).push(Routerconstaints.removestudent),
          ),
      
        ],
      ),
    );
  }
 Widget buildStudentMenu() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('View Profile'),
          onTap: () => GoRouter.of(context).push(Routerconstaints.sboard),
        ),
        ListTile(
          leading: Icon(Icons.edit,color: Colors.amber),
          title: Text('Edit Profile'),
          onTap: ()  {
    if (userData != null) {
      final student = Student(
        id: userData!['id'] ?? '',
        name: userData!['name'] ?? '',
        age: userData!['age'] ?? '',
        email: userData!['email'] ?? '',
        parentMobile: userData!['parentMobile'] ?? '',
        studentClass: userData!['studentClass'] ?? '',
        city: userData!['city'] ?? '',
      );
      GoRouter.of(context).push(Routerconstaints.editstudent, extra: student);
    }
  },
        ),
      ],
    );
  }
  Widget buildDashboardContent() {
    if (userData == null) {
      return Center(child: CircularProgressIndicator(strokeWidth: 1));
    }

    return Row(
      children: [
        if (isMenuOpen)
          Container(
            width: 250,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Text(
                    userData?['role'] ?? 'User',
                    style: TextStyle(color: const Color.fromARGB(255, 165, 203, 247), fontSize: 24),
                  ),
                ),
                if (userData?['role'] == 'Admin') buildAdminMenu(),
                if (userData?['role'] == 'Teacher') buildTeacherMenu(),
                if(userData?['role'] == 'Student') buildStudentMenu(),
              ],
            ),
          ),
        Expanded(
          child: Center(
            child: Text(
              'Welcome, ' + (userData?['name'] ?? ''),
              style:Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: buildMenuButton(),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout,color: Colors.grey,),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              GoRouter.of(context).go(Routerconstaints.login);
            },
          ),
        ],
      ),
      body: buildDashboardContent(),
    );
  }
}