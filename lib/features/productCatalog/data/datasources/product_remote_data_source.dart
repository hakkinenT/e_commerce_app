import 'dart:convert';

import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/utils/constants/constants.dart';
import 'package:e_commerce_app/core/utils/status_code_map/status_code_map.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductItemModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductItemModel>> getProducts() async {
    final response = await client.get(Uri.parse(productCatalogUrl),
        headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      List<ProductItemModel> products = [];
      List responseJson = json.decode(response.body);
      responseJson
          .map((e) => products.add(ProductItemModel.fromJson(e)))
          .toList();
      return products;
    } else {
      throw ServerException();
    }
  }
}
