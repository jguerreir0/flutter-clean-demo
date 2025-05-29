import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydemo/home/domain/usecases/products_use_case.dart';
import 'package:mydemo/home/home.dart';

part 'products_bloc_event.dart';
part 'products_bloc_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
    this.productsUseCase,
  ) : super(const ProductsInitial()) {
    on<OnGettingProducts>(_onGettingProducts);
  }
  final ProductsUseCase productsUseCase;

  Future<void> _onGettingProducts(
    OnGettingProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const GetProductsInProgress());
    try {
      final products = await productsUseCase();
      emit(
        GetProductsSuccess(products),
      );
    } catch (e) {
      emit(const GetProductsFailure('Currently unavailable, try again later'));
    }
  }
}
