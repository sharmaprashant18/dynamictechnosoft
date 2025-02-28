
class FormModel {
  final String name;
  final String email;
  final String address;
  final int age;
  
  FormModel({
    this.name = '',
    this.email = '',
    this.address = '',
    this.age=0
  });
  
  FormModel copyWith({
    String? name,
    String? email,
    String? address,
    int? age
  }) {
    return FormModel(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      age: age??this.age
    );
  }

  void update(Function(dynamic state) param0) {}
}