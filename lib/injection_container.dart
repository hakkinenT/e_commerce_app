import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'core/token/token_controller.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/login.dart';
import 'features/user/domain/usecases/register_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/cubit/login_form_validation_cubit.dart';
import 'features/user/presentation/cubit/register_user_form_validation_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Bloc
  sl.registerFactory(() => UserBloc(login: sl(), register: sl()));
  sl.registerFactory(() => LoginFormValidationCubit());
  sl.registerFactory(() => RegisterUserFormValidationCubit());

  // Use Cases
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(tokenController: sl(), client: sl()));

  //! Core
  sl.registerLazySingleton<TokenController>(
      () => TokenControllerImpl(jwtDecoder: sl(), secureStorage: sl()));

  //! External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => JwtDecoder());
}
