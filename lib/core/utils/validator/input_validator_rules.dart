import '../constants/constants.dart';

/// A set of rules to validate inputs.
class InputValidatorRules {
  /// Checks if the [input] is empty.
  static String? isNotEmpty(String? input) {
    if (input!.isEmpty) {
      return emptyFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] not starts with underscore.
  static String? notStartWithUnderscore(String? input) {
    if (input!.startsWith('_')) {
      return startWithUnderscoreFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] not starts with numbers.
  static String? notStartWithNumber(String? input) {
    if (input!.startsWith(RegExp(r'[0-9]'))) {
      return startWithNumberFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] is a valid email.
  static String? validEmail(String? input) {
    if (RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input!) == false) {
      return invalidEmailFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] has at least 8 caracters.
  static String? hasEightChars(String? input) {
    if (input!.length < 8) {
      return passwordLengthFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] has letters.
  static String? hasLetter(String? input) {
    if (input!.contains(RegExp(r'[a-zA-Z]')) == false) {
      return passwordHasNotLetterFailureMessage;
    }
    return null;
  }

  /// Checks if the [input] has numbers.
  static String? hasNumber(String? input) {
    if (input!.contains(RegExp(r'[0-9]')) == false) {
      return passwordHasNotNumberFailureMessage;
    }
    return null;
  }
}
