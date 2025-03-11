class Student {
  final String id;
  final String name;
  final String email;
  final String parentMobile;
  final String studentClass;
  final String city;
  final String age;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.parentMobile,
    required this.studentClass,
    required this.city,
    required this.age
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age':age,
        'email': email,
        'parentMobile': parentMobile,
        'studentClass': studentClass,
        'city': city,
      };

  factory Student.fromJson(Map<String, dynamic> json, [String? id]) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      parentMobile: json['parentMobile'],
      studentClass: json['studentClass'],
      city: json['city'],
    );
  }
 
}