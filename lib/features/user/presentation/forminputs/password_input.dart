import 'package:e_commerce_app/core/utils/validator/combine_validators.dart';
import 'package:e_commerce_app/core/utils/validator/input_validator.dart';
import 'package:e_commerce_app/core/utils/validator/input_validator_rules.dart';

class PasswordInput extends InputValidator with CombineValidators<String?> {
  const PasswordInput({required super.value});

  @override
  @override
  InvalidInputFailure? validate() {
    final inputMessage = combine([
      () => InputValidatorRules.isNotEmpty(value),
      () => InputValidatorRules.hasEightChars(value),
      () => InputValidatorRules.hasLetter(value),
      () => InputValidatorRules.hasNumber(value)
    ]);

    if (inputMessage != null) return InvalidInputFailure(message: inputMessage);

    return null;
  }
}
