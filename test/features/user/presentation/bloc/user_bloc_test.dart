import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/params/user_params.dart';
import 'package:e_commerce_app/features/user/domain/entities/user.dart';
import 'package:e_commerce_app/features/user/domain/usecases/login.dart';
import 'package:e_commerce_app/features/user/domain/usecases/register_user.dart';
import 'package:e_commerce_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'user_bloc_test.mocks.dart';

@GenerateMocks([Login, RegisterUser])
void main() {
  late MockRegisterUser mockRegisterUser;
  late MockLogin mockLogin;
  late UserBloc bloc;

  setUp(() {
    mockLogin = MockLogin();
    mockRegisterUser = MockRegisterUser();
    bloc = UserBloc(
      login: mockLogin,
      register: mockRegisterUser,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(UserEmpty()));
  });

  group('Login', () {
    const user = User(email: "joaoemail@email.com", password: "jwth1234");
    const userResponse = User(
      id: 1,
      username: "João",
      email: "joaoemail@email.com",
    );

    test('should get data from the concrete use case login', () async {
      when(mockLogin(any)).thenAnswer((_) async => const Right(userResponse));

      bloc.add(const UserLogged(user: user));

      await untilCalled(mockLogin(any));

      verify(
          mockLogin(UserParams(email: user.email, password: user.password!)));
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when UserLogged is added and get data fails.',
      setUp: () {
        when(mockLogin(any)).thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const UserLogged(user: user)),
      expect: () => <UserState>[
        UserLoading(),
        const UserError(message: serverFailureMessage)
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserSucces] when UserLogged is added and get data is successfully.',
      setUp: () {
        when(mockLogin(any)).thenAnswer((_) async => const Right(userResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const UserLogged(user: user)),
      expect: () =>
          <UserState>[UserLoading(), const UserSuccess(user: userResponse)],
    );
  });

  group('RegisterUser', () {
    const user = User(
        username: "João", email: "joaoemail@email.com", password: "jwth1234");
    const userResponse = User(
      id: 1,
      username: "João",
      email: "joaoemail@email.com",
    );

    test('should get data from the concrete use case register user', () async {
      when(mockRegisterUser(any))
          .thenAnswer((_) async => const Right(userResponse));

      bloc.add(const UserRegistered(user: user));

      await untilCalled(mockRegisterUser(any));

      verify(mockRegisterUser(UserParams(
          username: user.username,
          email: user.email,
          password: user.password!)));
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when UserRegistered is added and get data fails.',
      setUp: () {
        when(mockRegisterUser(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const UserRegistered(user: user)),
      expect: () => <UserState>[
        UserLoading(),
        const UserError(message: serverFailureMessage)
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserSuccess] when UserRegistered is added and get data is successfully.',
      setUp: () {
        when(mockRegisterUser(any))
            .thenAnswer((_) async => const Right(userResponse));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const UserRegistered(user: user)),
      expect: () =>
          <UserState>[UserLoading(), const UserSuccess(user: userResponse)],
    );
  });
}
