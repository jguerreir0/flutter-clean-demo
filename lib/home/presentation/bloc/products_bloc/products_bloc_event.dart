part of 'products_bloc.dart';

abstract class ProductsEvent {
  const ProductsEvent();
}

class OnGettingProducts extends ProductsEvent {
  const OnGettingProducts();
}
