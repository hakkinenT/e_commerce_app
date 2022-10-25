import 'package:e_commerce_app/features/user/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {super.id, super.username, required super.email, super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as int?,
        username: json['username'] as String?,
        email: json['email'] as String,
        password: json['password'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "email": email, "password": password};
  }
}
