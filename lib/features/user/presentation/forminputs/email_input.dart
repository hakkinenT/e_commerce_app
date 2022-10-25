import 'package:e_commerce_app/core/validator/combine_validators.dart';
import 'package:e_commerce_app/core/validator/input_validator.dart';
import 'package:e_commerce_app/core/validator/input_validator_rules.dart';

class EmailInput extends InputValidator with CombineValidators<String?> {
  const EmailInput({required super.value});

  @override
  InvalidInputFailure? validate() {
    final validatedMessage = combine([
      () => InputValidatorRules.isNotEmpty(value),
      () => InputValidatorRules.validEmail(value),
    ]);

    if (validatedMessage != null) {
      return InvalidInputFailure(message: validatedMessage);
    }

    return null;
  }
}
