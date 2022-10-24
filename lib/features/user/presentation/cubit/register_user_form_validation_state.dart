part of 'register_user_form_validation_cubit.dart';

class RegisterUserFormValidationState extends Equatable {
  final UsernameInput username;
  final EmailInput email;
  final PasswordInput password;
  final FormStatus status;

  const RegisterUserFormValidationState(
      {this.username = const UsernameInput(value: ""),
      this.email = const EmailInput(value: ""),
      this.password = const PasswordInput(value: ""),
      this.status = FormStatus.initial});

  @override
  List<Object> get props => [username, email, password, status];

  RegisterUserFormValidationState copyWith(
      {UsernameInput? username,
      EmailInput? email,
      PasswordInput? password,
      FormStatus? status}) {
    return RegisterUserFormValidationState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}
