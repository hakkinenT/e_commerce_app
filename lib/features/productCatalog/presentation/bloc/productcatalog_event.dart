part of 'productcatalog_bloc.dart';

abstract class ProductcatalogEvent extends Equatable {
  const ProductcatalogEvent();

  @override
  List<Object> get props => [];
}

class ProductcatalogFetched extends ProductcatalogEvent {}
