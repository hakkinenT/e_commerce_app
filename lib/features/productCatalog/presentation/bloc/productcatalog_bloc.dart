import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constants/constants.dart';
import '../../domain/entities/product_item.dart';
import '../../domain/usecases/get_products.dart';

part 'productcatalog_event.dart';
part 'productcatalog_state.dart';

class ProductcatalogBloc
    extends Bloc<ProductcatalogEvent, ProductcatalogState> {
  final GetProducts getProducts;

  ProductcatalogBloc({required GetProducts products})
      : getProducts = products,
        super(ProductcatalogEmpty()) {
    on<ProductcatalogFetched>(_onProductcatalogFetched);
  }

  Future<void> _onProductcatalogFetched(
      ProductcatalogEvent event, Emitter<ProductcatalogState> emit) async {
    emit(ProductcatalogLoading());
    final productsOrFailure = await getProducts(const NoParams());

    productsOrFailure.fold(
        (failure) =>
            emit(ProductcatalogError(message: _mapFailureToMessage(failure))),
        (products) => emit(ProductcatalogSuccess(productItems: products)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CachedFailure:
        return cacheFailureMessage;
      default:
        return 'UnexpectedError';
    }
  }
}
