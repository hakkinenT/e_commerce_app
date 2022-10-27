import 'dart:convert';

import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductItemModel>> getLastProducts();
  Future<void> cacheProducts(List<ProductItemModel> productToCache);
}

const cachedListProduct = 'CACHED_LIST_PRODUCT';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductItemModel> productToCache) {
    final productListJsonString = json.encode(productToCache
        .map<Map<String, dynamic>>((productItem) => productItem.toJson())
        .toList());
    return sharedPreferences.setString(
        cachedListProduct, productListJsonString);
  }

  @override
  Future<List<ProductItemModel>> getLastProducts() async {
    final cachedList = sharedPreferences.getString(cachedListProduct);

    if (cachedList != null) {
      final productList = (json.decode(cachedList) as List<dynamic>)
          .map((item) => ProductItemModel.fromJson(item))
          .toList();

      return Future.value(productList);
    } else {
      throw CachedException();
    }
  }
}
