import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product.dart';
import 'package:e_commerce_app/features/productCatalog/domain/entities/product_item.dart';
import 'package:e_commerce_app/features/productCatalog/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/productCatalog/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository mockProductRepository;
  late GetProducts usecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProducts(repository: mockProductRepository);
  });

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
        expirationDate: DateTime(2023, 05, 02),
        product: const Product(name: "Manteiga")),
    ProductItem(
        itemCode: "103",
        brand: "Delícia",
        price: 10.50,
        imageUrl: "http://",
        expirationDate: DateTime(2023, 05, 02),
        product: const Product(name: "Margarina")),
  ];

  group('GetProducts', () {
    test('should return ProductItems from repository', () async {
      when(mockProductRepository.getProducts())
          .thenAnswer((_) async => Right(productList));

      final result = await usecase(const NoParams());

      expect(result, Right(productList));

      verify(mockProductRepository.getProducts());

      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
