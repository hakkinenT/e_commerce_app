part of 'login_form_validation_cubit.dart';

class LoginFormValidationState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormStatus status;

  const LoginFormValidationState(
      {this.email = const EmailInput(value: ""),
      this.password = const PasswordInput(value: ""),
      this.status = FormStatus.initial});

  @override
  List<Object> get props => [email, password, status];

  LoginFormValidationState copyWith(
      {EmailInput? email, PasswordInput? password, FormStatus? status}) {
    return LoginFormValidationState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}
