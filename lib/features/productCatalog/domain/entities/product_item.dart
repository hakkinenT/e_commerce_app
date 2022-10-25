import 'package:e_commerce_app/features/productCatalog/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ProductItem extends Equatable {
  final String itemCode;
  final String brand;
  final double price;
  final String imageUrl;
  final DateTime expirationDate;
  final Product product;

  const ProductItem(
      {required this.itemCode,
      required this.brand,
      required this.price,
      required this.imageUrl,
      required this.expirationDate,
      required this.product});

  @override
  List<Object?> get props =>
      [itemCode, brand, price, imageUrl, expirationDate, product];
}
