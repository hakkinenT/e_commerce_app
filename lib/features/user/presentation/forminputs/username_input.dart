import 'package:e_commerce_app/core/validator/combine_validators.dart';
import 'package:e_commerce_app/core/validator/input_validator.dart';
import 'package:e_commerce_app/core/validator/input_validator_rules.dart';

class UsernameInput extends InputValidator with CombineValidators<String?> {
  const UsernameInput({required super.value});

  @override
  InvalidInputFailure? validate() {
    final inputMessage = combine([
      () => InputValidatorRules.isNotEmpty(value),
      () => InputValidatorRules.notStartWithNumber(value),
      () => InputValidatorRules.notStartWithUnderscore(value)
    ]);

    if (inputMessage != null) {
      return InvalidInputFailure(message: inputMessage);
    }

    return null;
  }
}
