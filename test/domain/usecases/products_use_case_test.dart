import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/home/domain/usecases/products_use_case.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late ProductsUseCase productsUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();

    productsUseCase = ProductsUseCase(mockProductRepository);
  });

  test('should return Product List when productsUseCase is called', () async {
    when(() => mockProductRepository.getProducts()).thenAnswer((_) async => []);

    final result = await productsUseCase();

    expect(result, equals([]));
    verify(() => mockProductRepository.getProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('should throw when productsUseCase throws', () async {
    when(() => mockProductRepository.getProducts())
        .thenThrow(Exception('Something went wrong'));

    expect(() => productsUseCase(), throwsA(isA<Exception>()));
  });
}
