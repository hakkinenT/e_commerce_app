import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/params/user_params.dart';
import 'package:e_commerce_app/features/user/domain/entities/user.dart';
import 'package:e_commerce_app/features/user/domain/usecases/register_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late RegisterUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = RegisterUser(repository: mockUserRepository);
  });

  group('registerUser', () {
    const user = User(
        username: "João", email: "joaoemail@email.com", password: "12345678");
    test('should return a user data if the register is successfully', () async {
      when(mockUserRepository.registerUser(any))
          .thenAnswer((_) async => const Right(user));

      final result = await usecase(const UserParams(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678"));

      expect(result, const Right(user));

      verify(mockUserRepository.registerUser(const User(
          username: "João",
          email: "joaoemail@email.com",
          password: "12345678")));

      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
