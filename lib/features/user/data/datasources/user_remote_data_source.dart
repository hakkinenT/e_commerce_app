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
  Future<UserModel> login(UserModel userModel) async {
    final response = await client.post(Uri.parse('$baseUrl/login'),
        body: json
            .encode({"email": userModel.email, "password": userModel.password}),
        headers: {'Content-Type': 'application/json'});
    return await _authenticateResult(response);
  }

  @override
  Future<UserModel> registerUser(UserModel userModel) async {
    final response = await client.post(Uri.parse('$baseUrl/register'),
        body: json.encode({
          "username": userModel.username,
          "email": userModel.email,
          "password": userModel.password
        }),
        headers: {'Content-Type': 'application/json'});
    return await _authenticateResult(response);
  }

  Future<UserModel> _authenticateResult(http.Response response) async {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      tokenController.setToken(data['accessToken']);

      return UserModel.fromJson(data['user']);
    } else {
      throw ServerException();
    }
  }
}
