import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/validator/form_validator.dart';
import '../forminputs/email_input.dart';
import '../forminputs/password_input.dart';
import '../forminputs/username_input.dart';

part 'register_user_form_validation_state.dart';

class RegisterUserFormValidationCubit
    extends Cubit<RegisterUserFormValidationState> {
  RegisterUserFormValidationCubit()
      : super(const RegisterUserFormValidationState());

  void usernameChanged(String username) {
    final usernameInput = UsernameInput(value: username);
    emit(state.copyWith(
        username: usernameInput,
        status: FormValidator.validate(
            inputs: [usernameInput, state.email, state.password])));
  }

  void emailChanged(String email) {
    final emailInput = EmailInput(value: email);
    emit(state.copyWith(
        email: emailInput,
        status: FormValidator.validate(
            inputs: [state.username, emailInput, state.password])));
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput(value: password);
    emit(state.copyWith(
        password: passwordInput,
        status: FormValidator.validate(
            inputs: [state.username, state.email, passwordInput])));
  }
}
