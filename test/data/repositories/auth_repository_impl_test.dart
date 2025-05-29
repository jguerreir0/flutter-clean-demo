import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/login/data/repositories/auth_repository_impl.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthApi = MockAuthApi();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthApi);
  });

  test('should call api login and return UserModel', () async {
    when(() => mockAuthApi.login(username, password))
        .thenAnswer((_) async => expectedUser);

    final result = await authRepositoryImpl.login(username, password);

    expect(result, expectedUser);
    verify(() => mockAuthApi.login(username, password)).called(1);
    verifyNoMoreInteractions(mockAuthApi);
  });

  test('should throw if api login throws', () async {
    when(() => mockAuthApi.login(username, password))
        .thenThrow(Exception('Invalid credentials'));

    expect(
        () => mockAuthApi.login(username, password), throwsA(isA<Exception>()));
  });
}
