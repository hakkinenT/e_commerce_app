import 'package:e_commerce_app/features/productCatalog/data/models/product_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_item.dart';

class ProductItemModel extends ProductItem {
  const ProductItemModel(
      {required super.itemCode,
      required super.brand,
      required super.price,
      required super.imageUrl,
      required super.expirationDate,
      required super.product});

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
        itemCode: json['code'],
        brand: json['brand'],
        price: json['price'],
        imageUrl: json['image-url'],
        expirationDate: DateTime.parse(json['expiration-date'].toString()),
        product: ProductModel.fromJson(json['product']));
  }

  Map<String, dynamic> toJson() {
    return {
      "code": itemCode,
      "brand": brand,
      "price": price,
      "image-url": imageUrl,
      "expiration-date": expirationDate.toIso8601String(),
      "product": {"name": product.name}
    };
  }
}
