import 'dart:convert';

import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_model.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final productItemModel = ProductItemModel(
      itemCode: "101",
      brand: "Nescafé",
      price: 2.50,
      imageUrl: "http://",
      expirationDate: DateTime(2023, 05, 02),
      product: const ProductModel(name: "Café"));
  group('fromJson', () {
    test('should return a ProductItem model when json data is passed', () {
      final productItemFromJson =
          ProductItemModel.fromJson(json.decode(fixture("product.json")));

      expect(productItemFromJson, productItemModel);
    });
  });

  group('toJson', () {
    test(
        'should return a json data when toJson method from ProductItem is called',
        () {
      final expectedJson = {
        "code": "101",
        "brand": "Nescafé",
        "price": 2.5,
        "image-url": "http://",
        "expiration-date": "2023-05-02T00:00:00.000",
        "product": {"name": "Café"}
      };

      final result = productItemModel.toJson();

      expect(result, expectedJson);
    });
  });
}
