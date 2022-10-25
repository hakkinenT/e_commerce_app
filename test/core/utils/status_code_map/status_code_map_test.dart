import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/utils/status_code_map/status_code_map.dart';
import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const userModel = UserModel(email: "email");
  const userModeList = <UserModel>[
    UserModel(email: "email 1"),
    UserModel(email: "email 2"),
    UserModel(email: "email 3"),
  ];

  String func() => "Sucesso";
  int funcInt() => 1;
  UserModel funcModel() => userModel;
  List<UserModel> funcList() => userModeList;

  test('should return a string when the code is 200', () {
    final response =
        StatusCodeMap.mapStatusCode(successFunction: () => func(), code: 200);
    expect(response, equals("Sucesso"));
  });

  test('should return a int when the code is 200', () {
    final response = StatusCodeMap.mapStatusCode(
        successFunction: () => funcInt(), code: 200);
    expect(response, equals(1));
  });

  test('should return a UserModel when the code is 200', () {
    final response = StatusCodeMap.mapStatusCode(
        successFunction: () => funcModel(), code: 200);
    expect(response, equals(userModel));
  });

  test('should return a List of UserModel when the code is 200', () {
    final response = StatusCodeMap.mapStatusCode(
        successFunction: () => funcList(), code: 200);
    expect(response, equals(userModeList));
  });

  test('should return a BadRequestException when the code is 400', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 400),
        throwsA(const TypeMatcher<BadRequestException>()));
  });
  //--
  test('should return a UnauthorizedException when the code is 401', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 401),
        throwsA(const TypeMatcher<UnauthorizedException>()));
  });

  test('should return a ForbiddenException when the code is 403', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 403),
        throwsA(const TypeMatcher<ForbiddenException>()));
  });

  test('should return a NotFoundException when the code is 404', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 404),
        throwsA(const TypeMatcher<NotFoundException>()));
  });

  test('should return a RequestTimeoutException when the code is 408', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 408),
        throwsA(const TypeMatcher<RequestTimeoutException>()));
  });

  test('should return a TooManyRequestsException when the code is 429', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 429),
        throwsA(const TypeMatcher<TooManyRequestsException>()));
  });

  test('should return a ClientClosedException when the code is 499', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 499),
        throwsA(const TypeMatcher<ClientClosedException>()));
  });

  test('should return a ServerException when the code is 500', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 500),
        throwsA(const TypeMatcher<ServerException>()));
  });

  test('should return a Exception when the code is unknown', () {
    const call = StatusCodeMap.mapStatusCode;
    expect(() => call(successFunction: () => func(), code: 501),
        throwsA(const TypeMatcher<Exception>()));
  });
}
