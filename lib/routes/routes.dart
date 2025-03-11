import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_management_system/fetures/auth/login/view/loginscreen.dart';
import 'package:school_management_system/fetures/auth/register/view/registrationscreen.dart';
import 'package:school_management_system/fetures/dashboard/dashboard.dart';
import 'package:school_management_system/fetures/student/addstudent/model/student.dart';
import 'package:school_management_system/fetures/student/addstudent/view/addstudent.dart';
import 'package:school_management_system/fetures/student/editstudent/view/editstudent.dart';
import 'package:school_management_system/fetures/student/getallstudents/view/getallstudents.dart';
import 'package:school_management_system/fetures/student/studentdata/view/studentdata.dart';
import 'package:school_management_system/fetures/teacher/addteacher/view/addteacher.dart';
import 'package:school_management_system/fetures/teacher/getallteachers/view/getallteachers.dart';
import 'package:school_management_system/routes/routerconstaints.dart';

class AppRouter{
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router =GoRouter(
    navigatorKey: _rootNavigatorKey,
     initialLocation: Routerconstaints.homeScreen,
      routes:<RouteBase>[
        GoRoute(path: Routerconstaints.homeScreen,
        builder: (context,state)=>Loginscreen(),
        ),
        GoRoute(
        path: Routerconstaints.dashboard,
        builder: (context, state) => const Dashboard(role: '',),),
        GoRoute(
        path: Routerconstaints.login,
        builder: (context, state) => Loginscreen(),),
        GoRoute(
          path: Routerconstaints.register,
        builder: (context, state) => RegistrationScreen()),
        GoRoute(
          path: Routerconstaints.addstudent,
        builder: (context, state) => const Addstudent()),
        GoRoute(
          path: Routerconstaints.manageteachers,
        builder: (context, state) => const Getallteachers()),
        GoRoute(
          path: Routerconstaints.removestudent,
        builder: (context, state) => const GetAllStudents()),
        GoRoute(
          path: Routerconstaints.addteacher,
        builder: (context, state) => const Addteacher()),
         GoRoute(
          path: Routerconstaints.manageteachers,
        builder: (context, state) => const Getallteachers()),
        GoRoute(
          path: Routerconstaints.removestudent,
          builder: (context, state) => const GetAllStudents()),
        GoRoute(
          path: Routerconstaints.sboard,
          builder: (context, state) => const Studentdata(),),
        GoRoute(
          path: Routerconstaints.editstudent,
          builder: (context, state) {
            final student = state.extra as Student;
          return Editstudent(student: student);
          }
    ),
        
      
      ]
  );
}