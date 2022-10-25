import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  final String? username;
  final String email;
  final String password;

  const UserParams(
      {this.username, required this.email, required this.password});

  @override
  List<Object?> get props => [username, email, password];
}
