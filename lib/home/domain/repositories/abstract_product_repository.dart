import 'package:mydemo/home/domain/models/product_model.dart';

abstract class AbstractProductRepository {
  Future<List<ProductModel>> getProducts();
}
