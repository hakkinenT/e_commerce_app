import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(User user) async {
    try {
      final loggedUser = await remoteDataSource
          .login(UserModel(email: user.email, password: user.password));
      return Right(loggedUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(User user) async {
    try {
      final registeredUser = await remoteDataSource.registerUser(UserModel(
          username: user.username, email: user.email, password: user.password));
      return Right(registeredUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
