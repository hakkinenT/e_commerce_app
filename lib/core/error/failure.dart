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
