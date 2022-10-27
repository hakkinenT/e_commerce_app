import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/constants/status_code_error_messages.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/productCatalog/domain/usecases/get_products.dart';
import 'package:e_commerce_app/features/productCatalog/presentation/bloc/productcatalog_bloc.dart';
import 'package:e_commerce_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'productcatalog_bloc_test.mocks.dart';

@GenerateMocks([GetProducts])
void main() {
  late MockGetProducts mockGetProducts;
  late ProductcatalogBloc bloc;

  setUp(() {
    mockGetProducts = MockGetProducts();
    bloc = ProductcatalogBloc(products: mockGetProducts);
  });

  group('GetProducts', () {
    var productList = <ProductItem>[
      ProductItem(
          itemCode: "101",
          brand: "Nescafé",
          price: 2.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 05, 02),
          product: const Product(name: "Café")),
      ProductItem(
          itemCode: "102",
          brand: "Qualy",
          price: 10.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 11, 08),
          product: const Product(name: "Manteiga")),
      ProductItem(
          itemCode: "103",
          brand: "Delícia",
          price: 8.50,
          imageUrl: "http://",
          expirationDate: DateTime(2023, 08, 12),
          product: const Product(name: "Margarina")),
    ];

    test('should get data from the concrete use case', () async {
      when(mockGetProducts(any)).thenAnswer((_) async => Right(productList));

      bloc.add(ProductcatalogFetched());

      await untilCalled(mockGetProducts(any));

      verify(mockGetProducts(const NoParams()));
    });

    blocTest<ProductcatalogBloc, ProductcatalogState>(
      '''emits [ProductcatalogLoading, ProductcatalogSuccess] 
      when ProductcatalogFetched is added and get data is success.''',
      setUp: () {
        when(mockGetProducts(any)).thenAnswer((_) async => Right(productList));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(ProductcatalogFetched()),
      expect: () => <ProductcatalogState>[
        ProductcatalogLoading(),
        ProductcatalogSuccess(productItems: productList)
      ],
    );

    blocTest<ProductcatalogBloc, ProductcatalogState>(
      '''emits [ProductcatalogLoading, ProductcatalogError] with appropriate
      error message when ProductcatalogFetched is added 
      and server error happens.''',
      setUp: () {
        when(mockGetProducts(any))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(ProductcatalogFetched()),
      expect: () => <ProductcatalogState>[
        ProductcatalogLoading(),
        const ProductcatalogError(message: internalServerErrorMessage)
      ],
    );

    blocTest<ProductcatalogBloc, ProductcatalogState>(
      '''emits [ProductcatalogLoading, ProductcatalogError] with appropriate
      error message when ProductcatalogFetched is added 
      and too many requests is made.''',
      setUp: () {
        when(mockGetProducts(any))
            .thenAnswer((_) async => Left(TooManyRequestsFailure()));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(ProductcatalogFetched()),
      expect: () => <ProductcatalogState>[
        ProductcatalogLoading(),
        const ProductcatalogError(message: tooManyRequestsErrorMessage)
      ],
    );
  });
}
