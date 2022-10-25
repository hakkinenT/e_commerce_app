import 'package:e_commerce_app/core/utils/validator/input_validator.dart';

/// A combine validators to classes of type [InputValidator].
mixin CombineValidators<T> on InputValidator {
  /// Checks if an input passes through [validators]
  ///
  /// Return null if the input passes all [validators].
  /// Return a String? if input fails at least one validator.
  T? combine(List<T? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
