import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/home/presentation/bloc/products_bloc/products_bloc.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  group('ProductsBloc', () {
    late MockProductsUseCase mockProductsUseCase;
    late ProductsBloc productsBloc;

    setUp(() {
      mockProductsUseCase = MockProductsUseCase();
      productsBloc = ProductsBloc(mockProductsUseCase);
    });

    blocTest<ProductsBloc, ProductsState>(
      'emits [GetProductsInProgress, GetProductsSuccess] on successful products fetch',
      build: () => productsBloc,
      setUp: () {
        when(() => mockProductsUseCase.call()).thenAnswer((_) async => []);
      },
      act: (bloc) => bloc.add(const OnGettingProducts()),
      expect: () => [isA<GetProductsInProgress>(), isA<GetProductsSuccess>()],
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [GetProductsInProgress, GetProductsFailure] on failed products fetch',
      build: () => productsBloc,
      setUp: () {
        when(() => mockProductsUseCase.call()).thenAnswer(
            (_) async => throw Exception('Error fetching products'));
      },
      act: (bloc) => bloc.add(const OnGettingProducts()),
      expect: () => [isA<GetProductsInProgress>(), isA<GetProductsFailure>()],
    );
  });
}
