import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [];
}

// SharedPreferences Failure
class CachedFailure extends Failure {}

// Http State Code Error Failure
class ServerFailure extends Failure {}

class BadRequestFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class ForbiddenFailure extends Failure {}

class NotFoundFailure extends Failure {}

class RequestTimeoutFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}

class ClientClosedFailure extends Failure {}
