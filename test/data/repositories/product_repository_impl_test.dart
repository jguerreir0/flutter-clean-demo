import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/home/data/repositories/product_repository_impl.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late ProductRepositoryImpl productRepositoryImpl;
  late MockProductApi mockProductApi;

  setUp(() {
    mockProductApi = MockProductApi();
    productRepositoryImpl = ProductRepositoryImpl(mockProductApi);
  });

  test('should call api getProducts and return Product List', () async {
    when(() => mockProductApi.getProducts()).thenAnswer((_) async => []);

    final result = await productRepositoryImpl.getProducts();

    expect(result, []);
    verify(() => mockProductApi.getProducts()).called(1);
    verifyNoMoreInteractions(mockProductApi);
  });

  test('should throw if api getProducts throws', () async {
    when(() => mockProductApi.getProducts())
        .thenThrow(Exception('Something went wrong'));

    expect(() => mockProductApi.getProducts(), throwsA(isA<Exception>()));
  });
}
