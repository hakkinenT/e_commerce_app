import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_local_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/productCatalog/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/productCatalog/domain/usecases/get_products.dart';
import 'package:e_commerce_app/features/productCatalog/presentation/bloc/productcatalog_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  sl.registerFactory(() => ProductcatalogBloc(products: sl()));

  // Use Cases
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => RegisterUser(repository: sl()));
  sl.registerLazySingleton(() => GetProducts(repository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(tokenController: sl(), client: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<TokenController>(
      () => TokenControllerImpl(jwtDecoder: sl(), secureStorage: sl()));
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => JwtDecoder());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
