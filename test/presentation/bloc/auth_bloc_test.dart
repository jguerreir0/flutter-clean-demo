import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydemo/login/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  group('AuthBloc', () {
    late MockLoginUseCase mockLoginUseCase;
    late MockAuthStorage mockAuthStorage;
    late AuthBloc authBloc;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockAuthStorage = MockAuthStorage();

      authBloc = AuthBloc(mockLoginUseCase, mockAuthStorage);
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthSuccess] on auth check with valid session',
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthStorage.hasSession())
            .thenAnswer((_) async => Future.value(true));
      },
      act: (bloc) => bloc.add(const OnAuthCheckRequested()),
      expect: () => [isA<AuthSuccess>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInitial] on auth check without valid session',
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthStorage.hasSession())
            .thenAnswer((_) async => Future.value(false));
      },
      act: (bloc) => bloc.add(const OnAuthCheckRequested()),
      expect: () => [isA<AuthInitial>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInProgress, AuthSuccess] on successful login',
      build: () => authBloc,
      setUp: () {
        when(() => mockLoginUseCase.call(any(), any()))
            .thenAnswer((_) async => expectedUser);
        when(() => mockAuthStorage.saveSession(
                accessToken: expectedUser.accessToken,
                refreshToken: expectedUser.refreshToken))
            .thenAnswer((_) async => Future.value());
      },
      act: (bloc) => bloc.add(const OnLogin('user', 'pass')),
      expect: () => [isA<AuthInProgress>(), isA<AuthSuccess>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInProgress, AuthFailure] on failed login',
      build: () => authBloc,
      setUp: () {
        when(() => mockLoginUseCase.call(any(), any()))
            .thenAnswer((_) async => throw Exception('Login failed'));
      },
      act: (bloc) => bloc.add(const OnLogin('user', 'pass')),
      expect: () => [isA<AuthInProgress>(), isA<AuthFailure>()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthInitial] on logout',
      build: () => authBloc,
      setUp: () {
        when(() => mockAuthStorage.clearSession())
            .thenAnswer((_) async => Future.value());
      },
      act: (bloc) => bloc.add(const OnLogout()),
      expect: () => [isA<AuthInitial>()],
    );
  });
}
