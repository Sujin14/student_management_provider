class StudentModel {
  final int? id;
  final String name;
  final int age;
  final String email;
  final int phone;
  final String imagePath;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      phone: map['phone'],
      imagePath: map['imagePath'],
    );
  }
}
