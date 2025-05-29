import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/login/data/data_sources/auth_api_impl.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late MockDio mockDio;
  late AuthApiImpl authApiImpl;

  setUp(() {
    mockDio = MockDio();
    authApiImpl = AuthApiImpl(mockDio);
  });

  test('should POST to /auth/login and return UserModel', () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: '/auth/login'),
      statusCode: 200,
      data: expectedUser.toJson(),
    );

    when(() => mockDio.post(
          any(),
          data: any(named: 'data'),
        )).thenAnswer((_) async => mockResponse);

    final result = await authApiImpl.login(username, password);

    expect(result.username, equals(expectedUser.username));
    expect(result.accessToken, equals(expectedUser.accessToken));
  });

  test('should throw if status code is not 200', () async {
    final mockResponse = Response(
      requestOptions: RequestOptions(path: '/auth/login'),
      statusCode: 401,
      data: {'message': 'Unauthorized'},
    );

    when(() => mockDio.post(any(), data: any(named: 'data')))
        .thenAnswer((_) async => mockResponse);

    expect(() => authApiImpl.login('bad', 'login'), throwsA(isA<Exception>()));
  });
}
