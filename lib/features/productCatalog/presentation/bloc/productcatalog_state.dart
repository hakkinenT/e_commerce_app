part of 'productcatalog_bloc.dart';

abstract class ProductcatalogState extends Equatable {
  const ProductcatalogState();

  @override
  List<Object> get props => [];
}

class ProductcatalogEmpty extends ProductcatalogState {}

class ProductcatalogLoading extends ProductcatalogState {}

class ProductcatalogSuccess extends ProductcatalogState {
  final List<ProductItem> productItems;

  const ProductcatalogSuccess({required this.productItems});

  @override
  List<Object> get props => [productItems];
}

class ProductcatalogError extends ProductcatalogState {
  final String message;

  const ProductcatalogError({required this.message});

  @override
  List<Object> get props => [message];
}
