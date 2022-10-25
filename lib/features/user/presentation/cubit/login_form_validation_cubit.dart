import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/validator/form_validator.dart';
import '../forminputs/email_input.dart';
import '../forminputs/password_input.dart';

part 'login_form_validation_state.dart';

class LoginFormValidationCubit extends Cubit<LoginFormValidationState> {
  LoginFormValidationCubit() : super(const LoginFormValidationState());

  void emailChanged(String email) {
    final emailInput = EmailInput(value: email);
    emit(state.copyWith(
        email: emailInput,
        status: FormValidator.validate(inputs: [emailInput, state.password])));
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput(value: password);
    emit(state.copyWith(
        password: passwordInput,
        status: FormValidator.validate(inputs: [state.email, passwordInput])));
  }
}
