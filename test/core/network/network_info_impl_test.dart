import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_impl_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  test('should forward the call to InternetDataConnection.hasConnection',
      () async {
    final tHasConnectionFuture = Future.value(true);

    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);

    final result = networkInfoImpl.isConnected;

    verify(mockInternetConnectionChecker.hasConnection);

    expect(result, tHasConnectionFuture);
  });
}
