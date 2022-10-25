import 'dart:convert';

import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/token/token_controller.dart';
import 'package:e_commerce_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'user_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([TokenController, http.Client])
void main() {
  late MockClient mockClient;
  late MockTokenController mockTokenController;
  late UserRemoteDataSourceImpl userRemoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    mockTokenController = MockTokenController();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(
        tokenController: mockTokenController, client: mockClient);
  });

  const userModelResult =
      UserModel(id: 1, username: "João", email: "joaoemail@email.com");

  group('login', () {
    const userModel = UserModel(email: "joaoemail@email.com", password: "joao");
    test(
        'should performe a POST request on URL with the user data in the body and application/json header',
        () {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      userRemoteDataSourceImpl.login(userModel);

      verify(mockClient.post(Uri.parse('$baseUrl/login'),
          body: userModel.toJson(),
          headers: {'Content-Type': "application/json"}));
    });

    test('should return user data when the response code is 200', () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      final result = await userRemoteDataSourceImpl.login(userModel);

      expect(result, equals(userModelResult));
    });

    test('should verify if token is saved in the cache', () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      final Map<String, dynamic> data =
          json.decode(fixture('api_response.json'));

      await userRemoteDataSourceImpl.login(userModel);

      verify(mockTokenController.setToken(data['accessToken']));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
        () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final call = userRemoteDataSourceImpl.login;

      expect(
          () => call(userModel), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('register user', () {
    const userModel = UserModel(
        username: "João", email: "joaoemail@email.com", password: "joao");
    test(
        'should performe a POST request on URL with the user data in the body and application/json header',
        () {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      userRemoteDataSourceImpl.registerUser(userModel);

      verify(mockClient.post(Uri.parse('$baseUrl/register'),
          body: userModel.toJson(),
          headers: {'Content-Type': "application/json"}));
    });

    test('should return user data when the response code is 200', () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      final result = await userRemoteDataSourceImpl.registerUser(userModel);

      expect(result, equals(userModelResult));
    });

    test('should verify if token is saved in the cache', () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer(
              (_) async => http.Response(fixture('api_response.json'), 200));

      final Map<String, dynamic> data =
          json.decode(fixture('api_response.json'));

      await userRemoteDataSourceImpl.registerUser(userModel);

      verify(mockTokenController.setToken(data['accessToken']));
    });

    test(
        'should return a ServerException when the response code is 404 or other',
        () async {
      when(mockClient.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final call = userRemoteDataSourceImpl.registerUser;

      expect(
          () => call(userModel), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
