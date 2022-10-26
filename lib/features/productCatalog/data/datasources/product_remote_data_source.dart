import 'dart:convert';

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

    final List<ProductItemModel> successResponse = StatusCodeMap.mapStatusCode(
        successFunction: () => _convertJsonToList(response.body),
        code: response.statusCode);

    return successResponse;
  }

  List<ProductItemModel> _convertJsonToList(String jsonBody) {
    final productList = (json.decode(jsonBody) as List<dynamic>)
        .map((item) => ProductItemModel.fromJson(item))
        .toList();

    return productList;
  }
}
