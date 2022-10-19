import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/user/domain/repositories/user_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/params/user_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';

class Login extends UseCase<User, UserParams> {
  final UserRepository repository;

  Login({required this.repository});

  @override
  Future<Either<Failure, User>> call(params) async {
    return await repository
        .login(User(email: params.email, password: params.password));
  }
}
