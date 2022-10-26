import 'dart:convert';

import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_local_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastProducts', () {
    var productListModel =
        (json.decode(fixture("product_list.json")) as List<dynamic>)
            .map<ProductItemModel>((item) => ProductItemModel.fromJson(item))
            .toList();

    test(
        'should return a ProductItem list from SharedPreferences when there is on in the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("product_list.json"));

      final result = await localDataSourceImpl.getLastProducts();

      verify(mockSharedPreferences.getString(cachedListProduct));
      expect(result, equals(productListModel));
    });

    test('should throw a CacheException when there is no cached value',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = localDataSourceImpl.getLastProducts;

      expect(() => call(), throwsA(const TypeMatcher<CachedException>()));
    });
  });

  group('cacheProducts', () {
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
          expirationDate: DateTime(2023, 05, 02),
          product: const ProductModel(name: "Manteiga")),
      ProductItemModel(
          itemCode: "103",
          brand: "Delícia",
          price: 10.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 05, 02),
          product: const ProductModel(name: "Margarina")),
    ];

    test('should call SharedPreferences to cache the data', () {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      localDataSourceImpl.cacheProducts(productList);

      final expectedJsonString = json.encode(productList
          .map<Map<String, dynamic>>((productItem) => productItem.toJson())
          .toList());

      verify(mockSharedPreferences.setString(
          cachedListProduct, expectedJsonString));
    });
  });
}
