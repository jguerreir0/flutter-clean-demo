import 'package:dio/dio.dart';
import 'package:mydemo/home/data/data_sources/abstract_product_api.dart';
import 'package:mydemo/home/domain/models/product_model.dart';

class ProductApiImpl extends AbstractProductApi {
  ProductApiImpl(this.dio);

  final Dio dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('products');
      if (response.statusCode == 200) {
        final data = response.data['products'] as List;
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e, s) {
      throw Exception('Failed to load products: $e , $s');
    }
  }
}
