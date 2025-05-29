import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/home/data/data_sources/abstract_product_api.dart';
import 'package:mydemo/home/domain/repositories/abstract_product_repository.dart';
import 'package:mydemo/home/domain/usecases/products_use_case.dart';
import 'package:mydemo/login/data/data_sources/abstract_auth_api.dart';
import 'package:mydemo/login/domain/models/user_model.dart';
import 'package:mydemo/login/domain/repositories/abstract_auth_repository.dart';
import 'package:mydemo/login/domain/usecases/login_use_case.dart';
import 'package:mydemo/login/presentation/storage/auth_storage.dart';

const username = 'emilys';
const password = 'emilyspass';
const expectedUser = UserModel(
  id: 1,
  username: username,
  email: 'emily.johnson@x.dummyjson.com',
  firstName: 'Emily',
  lastName: 'Johnson',
  gender: 'female',
  image: '',
  accessToken: 'token123',
  refreshToken: 'refresh456',
);

class MockAuthApi extends Mock implements AbstractAuthApi {}

class MockProductApi extends Mock implements AbstractProductApi {}

class MockAuthRepository extends Mock implements AbstractAuthRepository {}

class MockProductRepository extends Mock implements AbstractProductRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockAuthStorage extends Mock implements AuthStorage {}

class MockProductsUseCase extends Mock implements ProductsUseCase {}

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}
