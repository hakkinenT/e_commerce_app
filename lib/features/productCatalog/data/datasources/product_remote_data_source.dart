import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/utils/constants/constants.dart';
import '../models/product_item_model.dart';

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
