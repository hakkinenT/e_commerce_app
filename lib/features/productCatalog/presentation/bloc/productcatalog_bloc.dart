import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'productcatalog_event.dart';
part 'productcatalog_state.dart';

class ProductcatalogBloc extends Bloc<ProductcatalogEvent, ProductcatalogState> {
  ProductcatalogBloc() : super(ProductcatalogInitial()) {
    on<ProductcatalogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
