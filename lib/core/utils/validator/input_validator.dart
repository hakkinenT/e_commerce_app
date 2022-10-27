import '../../error/failure.dart';

abstract class InputValidator {
  final String value;

  const InputValidator({required this.value});

  /// Whether the [value] is invalid.
  bool get invalid => validate() is InvalidInputFailure;

  /// Whether the [value] is valid.
  bool get valid => validate() == null;

  /// Return the appropriate error message for the current [value]
  /// if the [validate()] returns an [InvalidInputFailure]
  String? get errorMessage {
    final input = validate();
    if (input is InvalidInputFailure) {
      return input.message;
    } else {
      return null;
    }
  }

  /// Checks if the [value] passes all validation rules.
  ///
  /// Return null if all rules pass.
  /// Return [InvalidInputFailure] if it doesn't pass at least one rule.
  InvalidInputFailure? validate();
}

class InvalidInputFailure extends Failure {
  final String? message;
  const InvalidInputFailure({this.message});

  @override
  List<Object?> get props => [message];
}
