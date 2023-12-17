class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final int age;

  UserModel(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.age});

  factory UserModel.fromJson(Map<dynamic, dynamic> map) {
    return UserModel(
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      age: map['age'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    };
  }
}
