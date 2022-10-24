import 'package:e_commerce_app/core/validator/input_validator.dart';

/// The states of the FormStatus
enum FormStatus { initial, valid, invalid }

const _validatedStatus = <FormStatus>{FormStatus.valid};

extension FormStatusX on FormStatus {
  /// Checks if the current state of the [FormStatus] is [valid]
  bool get isValidated => _validatedStatus.contains(this);
}

class FormValidator {
  /// Checks if all [inputs] are valid
  ///
  /// Return [FormStatus.valid] if all inputs are valid.
  /// Return [FormStatus.invalid] if any input is invalid.
  static FormStatus validate({required List<InputValidator> inputs}) {
    final isValidate = inputs.every((input) => input.valid);

    if (isValidate) {
      return FormStatus.valid;
    } else {
      return FormStatus.invalid;
    }
  }
}
