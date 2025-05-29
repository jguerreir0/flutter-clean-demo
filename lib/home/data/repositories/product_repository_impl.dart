import 'package:mydemo/home/domain/models/product_model.dart';
import '../../domain/repositories/abstract_product_repository.dart';
import '../data_sources/abstract_product_api.dart';

class ProductRepositoryImpl extends AbstractProductRepository {
  ProductRepositoryImpl(this.productApi);

  final AbstractProductApi productApi;

  @override
  Future<List<ProductModel>> getProducts() => productApi.getProducts();
}
