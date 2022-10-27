import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// É um Adapter que mascara o uso da biblioteca externa
// Ou seja, é possível usar qualquer biblioteca extena que ofereça
// a mesma funcionalidade
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  // Serve como interface para o método da biblioteca externa
  // Por isso não tem o async/await, pois não interessa retornar
  // o valor resultante da chamada da funcão,
  // mas sim encaminhar a chamada para a biblioteca externa
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
