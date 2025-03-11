class Teacher {
  final String id;
  final String name;
  final String email;
  final String subject;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'subject': subject,
      };

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subject: json['subject'],
    );
  }
}