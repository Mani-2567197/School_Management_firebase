# school_management_system

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

project Name :- School Management System 
-------------
MVVM -> M - Model
        V - View
        VM - ViewModel
        repository
Features:
---------
1. Auth ---> Login 
             Register
2. Student --> Add, Edit, Update & delete
3. Teacher --> Add, Edit, Update & delete

Firebase as backend service.
Data stored in firestore database.
Created three collection in firestore database.
1. Users ---> role based authentication [Admin,Teacher,Student]
2. Students
3. Teachers

* Student data is stored in student collection & teachers data is stored in teachers collection.
* Admin can perform all operations like add,delete,edit,read for both teachers & students.
* teachers can only add,edit,delete,read students.

* we can swith from light mode to dark mode based on user choice.

dependency packages used :
--------------------------
  firebase_core: ^3.12.1
  firebase_auth: ^5.5.1
  firebase_storage: ^12.4.4
  dio: ^5.8.0+1
  cloud_firestore: ^5.6.5
  provider: ^6.1.2
  go_router: ^14.8.1
  shared_preferences: ^2.5.2


folder structure ;-
------------------
└── 📁lib
    └── 📁fetures
        └── 📁auth
            └── 📁login
                └── 📁model
                    └── loginmodel.dart
                └── 📁repository
                    └── loginrepository.dart
                └── 📁view
                    └── loginscreen.dart
                └── 📁viewmodel
                    └── loginviewmodel.dart
            └── 📁register
                └── 📁model
                    └── registrationmodel.dart
                └── 📁repository
                    └── registrationrepository.dart
                └── 📁view
                    └── registrationscreen.dart
                └── 📁viewmodel
                    └── registrationviewmodel.dart
        └── 📁dashboard
            └── dashboard.dart
        └── 📁student
            └── 📁addstudent
                └── 📁model
                    └── student.dart
                └── 📁repository
                    └── studentrepository.dart
                └── 📁view
                    └── addstudent.dart
                └── 📁viewmodel
                    └── addstudentviewmodel.dart
            └── 📁editstudent
                └── 📁view
                    └── editstudent.dart
            └── 📁getallstudents
                └── 📁view
                    └── getallstudents.dart
            └── 📁studentdata
                └── 📁view
                    └── studentdata.dart
        └── 📁teacher
            └── 📁addteacher
                └── 📁model
                    └── teacher.dart
                └── 📁repository
                    └── teacherrepository.dart
                └── 📁view
                    └── addteacher.dart
                └── 📁viewmodel
                    └── teachersviewmodel.dart
            └── 📁editteacher
                └── 📁view
                    └── editteacher.dart
            └── 📁getallteachers
                └── 📁view
                    └── getallteachers.dart
            └── 📁techerdata
                └── 📁view
                    └── techerdata.dart
    └── 📁routes
        └── routerconstaints.dart
        └── routes.dart
    └── 📁services
        └── authservices.dart
        └── cities.dart
    └── 📁utils
        └── colorconstaints.dart
        └── themeprovider.dart
    └── firebase_options.dart
    └── main.dart