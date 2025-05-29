import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/login/domain/usecases/login_use_case.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  test('should return UserModel when loginUseCase is called', () async {
    when(() => mockAuthRepository.login(username, password))
        .thenAnswer((_) async => expectedUser);

    final result = await loginUseCase(username, password);

    expect(result, equals(expectedUser));
    verify(() => mockAuthRepository.login(username, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should throw when loginUseCase throws', () async {
    when(() => mockAuthRepository.login(username, password))
        .thenThrow(Exception('Login failed'));

    expect(() => loginUseCase(username, password), throwsA(isA<Exception>()));
  });
}
