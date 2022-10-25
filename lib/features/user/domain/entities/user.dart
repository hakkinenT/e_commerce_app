import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? username;
  final String email;
  final String? password;

  const User({this.id, this.username, required this.email, this.password});

  @override
  List<Object?> get props => [id, username, email, password];
}
