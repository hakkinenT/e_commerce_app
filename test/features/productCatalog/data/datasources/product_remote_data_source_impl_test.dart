import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/utils/constants/constants.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ProductRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    remoteDataSourceImpl = ProductRemoteDataSourceImpl(client: mockClient);
  });

  group('getProducts', () {
    var productList = <ProductItemModel>[
      ProductItemModel(
          itemCode: "101",
          brand: "Nescafé",
          price: 2.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 05, 02),
          product: const ProductModel(name: "Café")),
      ProductItemModel(
          itemCode: "102",
          brand: "Qualy",
          price: 10.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 11, 08),
          product: const ProductModel(name: "Manteiga")),
      ProductItemModel(
          itemCode: "103",
          brand: "Delícia",
          price: 8.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 08, 12),
          product: const ProductModel(name: "Margarina")),
    ];

    test('should perform a GET request on api with application/json header',
        () {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('product_list.json'), 200));

      remoteDataSourceImpl.getProducts();

      verify(mockClient.get(Uri.parse(productCatalogUrl),
          headers: {"Content-type": "application/json"}));
    });

    test('should return a list of products from api when the code is 200',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('product_list.json'), 200));

      final result = await remoteDataSourceImpl.getProducts();

      expect(result, equals(productList));
    });

    test('should throw a server exception when the code is 500', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Something went wrong", 500));

      final call = remoteDataSourceImpl.getProducts;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
