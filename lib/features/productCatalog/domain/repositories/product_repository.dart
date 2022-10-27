import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';

import '../../../../core/error/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductItem>>> getProducts();
}
