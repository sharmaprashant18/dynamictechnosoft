class User {
  final String name;
  final String email;
  final int age;
  final String? id;
  User({required this.age, required this.email, required this.name, this.id});
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'age': age};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        age: json['age'],
        email: json['email'],
        name: json['name'],
        id: json['id']);
  }
}