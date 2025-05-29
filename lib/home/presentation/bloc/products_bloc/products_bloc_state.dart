part of 'products_bloc.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class GetProductsInProgress extends ProductsState {
  const GetProductsInProgress();
}

class GetProductsFailure extends ProductsState {
  final String errorMsg;

  const GetProductsFailure(this.errorMsg);
}

class GetProductsSuccess extends ProductsState {
  final List<ProductModel> products;

  const GetProductsSuccess(this.products);
}
