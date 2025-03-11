import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/fetures/student/addstudent/viewmodel/addstudentviewmodel.dart';
import 'package:school_management_system/fetures/teacher/addteacher/viewmodel/teachersviewmodel.dart';
import 'package:school_management_system/firebase_options.dart';
import 'package:school_management_system/routes/routes.dart';
import 'package:school_management_system/services/authservices.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   try {
   final value = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully! ,${value.name}');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => Addstudentviewmodel()),
        ChangeNotifierProvider(create: (context) => TeacherViewModel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Play School Management',
      //theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}


