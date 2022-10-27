import 'package:e_commerce_app/features/productCatalog/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({required super.name});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(name: json['name']);
  }

  Map<String, dynamic> toJson() => {"name": name};
}
