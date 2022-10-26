import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exception.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_local_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_item_model.dart';
import 'package:e_commerce_app/features/productCatalog/data/models/product_model.dart';
import 'package:e_commerce_app/features/productCatalog/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
void main() {
  late MockProductLocalDataSource mockLocalDataSource;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl repositoryImpl;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ProductRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getProducts', () {
    var productItemListModel = <ProductItemModel>[
      ProductItemModel(
          itemCode: "101",
          brand: "Nescafé",
          price: 2.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 05, 02),
          product: const ProductModel(name: "Café")),
      ProductItemModel(
          itemCode: "102",
          brand: "Qualy",
          price: 10.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 05, 02),
          product: const ProductModel(name: "Manteiga")),
    ];

    List<ProductItem> productItemList = productItemListModel;

    test('should check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => productItemListModel);

      await repositoryImpl.getProducts();

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      test(
          'should return data from when the call to remote data source is success',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => productItemListModel);

        final result = await repositoryImpl.getProducts();

        verify(mockRemoteDataSource.getProducts());

        expect(result, equals(Right(productItemList)));
      });

      test(
          'should cache the data locally when the call to remote data source is success.',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => productItemListModel);

        when(mockLocalDataSource.cacheProducts(any))
            .thenAnswer((_) async => Unit);

        await repositoryImpl.getProducts();

        verify(mockRemoteDataSource.getProducts());
        verify(mockLocalDataSource.cacheProducts(productItemListModel));
      });

      test(
          'should return a server failure when an unexpected error occurs on the server.',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataSource.getProducts()).thenThrow(ServerException());

        final result = await repositoryImpl.getProducts();

        verify(mockRemoteDataSource.getProducts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      test(
          'should return a server failure when an unexpected error occurs on the server.',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataSource.getProducts()).thenThrow(ServerException());

        final result = await repositoryImpl.getProducts();

        verify(mockRemoteDataSource.getProducts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      test(
          'should return a too many requests failure when the user do many requisitions.',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(mockRemoteDataSource.getProducts())
            .thenThrow(TooManyRequestsException());

        final result = await repositoryImpl.getProducts();

        verify(mockRemoteDataSource.getProducts());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(TooManyRequestsFailure())));
      });
    });

    group('device is offline', () {
      test(
          'should return last locally cached product when the cached data is present',
          () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => productItemListModel);

        when(mockLocalDataSource.getLastProducts())
            .thenAnswer((_) async => productItemListModel);

        final result = await repositoryImpl.getProducts();

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastProducts());
        expect(result, equals(Right(productItemList)));
      });

      test('should return CacheFailure when there is no cached data', () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        when(mockRemoteDataSource.getProducts())
            .thenAnswer((_) async => productItemListModel);

        when(mockLocalDataSource.getLastProducts())
            .thenThrow(CachedException());

        final result = await repositoryImpl.getProducts();

        verify(mockLocalDataSource.getLastProducts());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(CachedFailure())));
      });
    });
  });
}
