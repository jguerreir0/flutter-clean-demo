import 'package:mydemo/home/home.dart';

abstract class AbstractProductApi {
  Future<List<ProductModel>> getProducts();
}
