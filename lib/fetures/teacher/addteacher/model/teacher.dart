class Teacher {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String employeementtype;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.employeementtype,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'subject': subject,
        'employeementtype':employeementtype,
      };

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subject: json['subject'],
      employeementtype:json['employeementtype'],
    );
  }
}