import 'dart:convert';

import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const userModel =
      UserModel(name: "João", email: "joaoemail@email.com", password: "joao");

  group('fromJson', () {
    test(
        'should return a [UserModel] when the named constructor fromJson is called',
        () {
      final result = UserModel.fromJson(json.decode(fixture('user.json')));
      expect(result, userModel);
    });
  });

  group('toJson', () {
    test('should convert the object [UserModel] into the json format', () {
      final expectedJson = <String, dynamic>{
        "name": "João",
        "email": "joaoemail@email.com",
        "password": "joao"
      };

      final result = userModel.toJson();

      expect(result, expectedJson);
    });
  });
}
