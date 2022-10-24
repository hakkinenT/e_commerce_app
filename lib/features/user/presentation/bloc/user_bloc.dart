import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/params/user_params.dart';
import 'package:e_commerce_app/core/validator/input_validator.dart';
import 'package:e_commerce_app/features/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register_user.dart';

part 'user_event.dart';
part 'user_state.dart';

const String serverFailureMessage = 'Server Failure';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login userLogin;
  final RegisterUser registerUser;

  UserBloc({
    required Login login,
    required RegisterUser register,
  })  : userLogin = login,
        registerUser = register,
        super(UserEmpty()) {
    on<UserLogged>(_onUserLogged);
    on<UserRegistered>(_onUserRegistered);
  }

  Future<void> _onUserLogged(UserLogged event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await userLogin(
        UserParams(email: event.user.email, password: event.user.password!));

    _eitherSuccessOrErrorState(failureOrUser, emit);
  }

  Future<void> _onUserRegistered(
      UserRegistered event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final failureOrUser = await registerUser(UserParams(
        username: event.user.username,
        email: event.user.email,
        password: event.user.password!));

    _eitherSuccessOrErrorState(failureOrUser, emit);
  }

  _eitherSuccessOrErrorState(
      Either<Failure, User> either, Emitter<UserState> emit) {
    either.fold(
        (failure) => emit(const UserError(message: serverFailureMessage)),
        (user) => emit(UserSuccess(user: user)));
  }
}
