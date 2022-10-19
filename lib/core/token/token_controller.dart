import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class TokenController {
  void setToken(String token);
  Future<String?> getToken();
  bool isExpired(String token);
}

const tokenKey = 'TOKEN_KEY';

class TokenControllerImpl extends TokenController {
  final FlutterSecureStorage secureStorage;
  final JwtDecoder decoder;

  TokenControllerImpl(
      {required this.secureStorage, required JwtDecoder jwtDecoder})
      : decoder = jwtDecoder;

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: tokenKey);
  }

  @override
  bool isExpired(String token) => JwtDecoder.isExpired(token);

  @override
  void setToken(String token) async {
    await secureStorage.write(key: tokenKey, value: token);
  }
}
