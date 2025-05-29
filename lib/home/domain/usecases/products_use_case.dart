import 'package:mydemo/home/domain/repositories/abstract_product_repository.dart';
import 'package:mydemo/home/home.dart';

class ProductsUseCase {
  ProductsUseCase(this.productRepository);

  final AbstractProductRepository productRepository;

  Future<List<ProductModel>> call() async =>
      await productRepository.getProducts();
}
