import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_local_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/productCatalog/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductItem>>> getProducts() async {
    if (await networkInfo.isConnected) {
      return _getRemoteProducts();
    } else {
      return _getLocallyProducts();
    }
  }

  Future<Either<Failure, List<ProductItem>>> _getRemoteProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      await localDataSource.cacheProducts(products);
      return Right(products);
    } on ServerException {
      return Left(ServerFailure());
    } on BadRequestException {
      return Left(BadRequestFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on RequestTimeoutException {
      return Left(RequestTimeoutFailure());
    } on TooManyRequestsException {
      return Left(TooManyRequestsFailure());
    } on ClientClosedException {
      return Left(ClientClosedFailure());
    }
  }

  Future<Either<Failure, List<ProductItem>>> _getLocallyProducts() async {
    try {
      final productsCached = await localDataSource.getLastProducts();
      return Right(productsCached);
    } on CachedException {
      return Left(CachedFailure());
    }
  }
}
