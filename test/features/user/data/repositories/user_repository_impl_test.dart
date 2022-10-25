import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:e_commerce_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:e_commerce_app/features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockUserRemoteDataSource,
    );
  });

  group('login', () {
    const userModel = UserModel(
        id: 1, username: "João", email: "joaoemail@email.com", password: null);
    const User user = userModel;
    test('should do login in the app', () async {
      when(mockUserRemoteDataSource.login(any))
          .thenAnswer((_) async => userModel);

      final result = await repository.login(
          const User(email: "joaoemail@email.com", password: "12345678"));

      verify(mockUserRemoteDataSource.login(
          const UserModel(email: "joaoemail@email.com", password: "12345678")));

      expect(result, equals(const Right(user)));
    });

    test('should return server failure when the login is unsucessfully',
        () async {
      when(mockUserRemoteDataSource.login(any)).thenThrow(ServerException());

      final result = await repository.login(
          const User(email: "joaoemail@email.com", password: "12345678"));

      verify(mockUserRemoteDataSource.login(
          const UserModel(email: "joaoemail@email.com", password: "12345678")));

      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('registerUser', () {
    const userModel = UserModel(
        id: 1, username: "João", email: "joaoemail@email.com", password: null);
    const User user = userModel;
    test('should register a user in the app', () async {
      when(mockUserRemoteDataSource.registerUser(any))
          .thenAnswer((_) async => userModel);

      final result = await repository.registerUser(const User(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678"));

      verify(mockUserRemoteDataSource.registerUser(const UserModel(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678")));

      expect(result, equals(const Right(user)));
    });

    test('should return server failure when the login is unsucessfully',
        () async {
      when(mockUserRemoteDataSource.registerUser(any))
          .thenThrow(ServerException());

      final result = await repository.registerUser(const User(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678"));

      verify(mockUserRemoteDataSource.registerUser(const UserModel(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678")));

      expect(result, equals(Left(ServerFailure())));
    });
  });
}
