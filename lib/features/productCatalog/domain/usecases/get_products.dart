import 'package:e_commerce_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/productCatalog/domain/repositories/product_repository.dart';

class GetProducts extends UseCase<List<ProductItem>, NoParams> {
  final ProductRepository repository;

  GetProducts({required this.repository});

  @override
  Future<Either<Failure, List<ProductItem>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
