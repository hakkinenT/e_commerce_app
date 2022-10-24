part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLogged extends UserEvent {
  final User user;
  const UserLogged({required this.user});

  @override
  List<Object> get props => [user];
}

class UserRegistered extends UserEvent {
  final User user;
  const UserRegistered({required this.user});

  @override
  List<Object> get props => [user];
}
