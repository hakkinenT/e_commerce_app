import 'dart:convert';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/token/token_controller.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> login(UserModel userModel);
  Future<UserModel> registerUser(UserModel userModel);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final TokenController tokenController;
  final http.Client client;

  UserRemoteDataSourceImpl(
      {required this.tokenController, required this.client});

  @override
  Future<UserModel> login(UserModel userModel) =>
      _authenticate('$baseUrl/login', userModel);

  @override
  Future<UserModel> registerUser(UserModel userModel) =>
      _authenticate('$baseUrl/register', userModel);

  Future<UserModel> _authenticate(String url, UserModel userModel) async {
    final response = await client.post(Uri.parse(url),
        body: userModel.toJson(),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      tokenController.setToken(data['accessToken']);

      return UserModel.fromJson(data['user']);
    } else {
      throw ServerException();
    }
  }
}
