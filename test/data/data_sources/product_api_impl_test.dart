import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/home/data/data_sources/product_api_impl.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late MockDio mockDio;
  late ProductApiImpl productApiImpl;

  setUp(() {
    mockDio = MockDio();
    productApiImpl = ProductApiImpl(mockDio);
  });

  test('should GET to /products and return List<Product>', () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: 'products'),
      statusCode: 200,
      data: {
        'products': [],
      },
    );

    when(() => mockDio.get(
          any(),
        )).thenAnswer((_) async => mockResponse);

    final result = await productApiImpl.getProducts();

    expect(result, equals([]));
  });

  test('should throw if status code is not 200', () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: 'products'),
      statusCode: 401,
      data: {'message': 'Unauthorized'},
    );

    when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

    expect(() => productApiImpl.getProducts(), throwsA(isA<Exception>()));
  });
}
