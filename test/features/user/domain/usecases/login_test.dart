import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/params/user_params.dart';
import 'package:e_commerce_app/features/user/domain/entities/user.dart';
import 'package:e_commerce_app/features/user/domain/repositories/user_repository.dart';
import 'package:e_commerce_app/features/user/domain/usecases/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late Login usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = Login(repository: mockUserRepository);
  });

  group('login', () {
    const user =
        User(name: "João", email: "joaoemail@email.com", password: "12345678");
    test('should return user data after login in the app', () async {
      when(mockUserRepository.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => const Right(user));

      final result = await usecase(
          const UserParams(email: "joaoemail@email.com", password: "12345678"));

      expect(result, const Right(user));

      verify(mockUserRepository.login(
          email: "joaoemail@email.com", password: "12345678"));

      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
