import 'package:e_commerce_app/core/utils/constants/constants.dart';
import 'package:e_commerce_app/core/utils/validator/form_validator.dart';
import 'package:e_commerce_app/features/user/presentation/forminputs/email_input.dart';
import 'package:e_commerce_app/features/user/presentation/forminputs/username_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return FormStatus.valid when fields are valid', () async {
    const nameInput = UsernameInput(value: "Tawanna");
    const emailInput = EmailInput(value: "thol@email.com");

    final result = FormValidator.validate(inputs: [
      nameInput,
      emailInput,
    ]);

    expect(result, FormStatus.valid);
    expect(nameInput.errorMessage, null);
    expect(emailInput.errorMessage, null);
  });

  test('should return FormStatus.invalid when name field is invalid', () async {
    const nameInput = UsernameInput(value: "_Tawanna");
    const emailInput = EmailInput(value: "thol@email.com");

    final result = FormValidator.validate(inputs: [
      nameInput,
      emailInput,
    ]);

    expect(result, FormStatus.invalid);
    expect(nameInput.errorMessage, startWithUnderscoreFailureMessage);
  });

  test('should return FormStatus.invalid when email field is invalid',
      () async {
    const nameInput = UsernameInput(value: "Tawanna");
    const emailInput = EmailInput(value: "tholemail.com");

    final result = FormValidator.validate(inputs: [
      nameInput,
      emailInput,
    ]);

    expect(result, FormStatus.invalid);
    expect(emailInput.errorMessage, invalidEmailFailureMessage);
  });
}
