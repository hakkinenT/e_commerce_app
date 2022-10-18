import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/user_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUser extends UseCase<User, UserParams> {
  final UserRepository repository;

  RegisterUser({required this.repository});

  @override
  Future<Either<Failure, User>> call(UserParams params) async {
    return await repository.registerUser(User(
        name: params.name!, email: params.email, password: params.password));
  }
}
