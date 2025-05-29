part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthInProgress extends AuthState {
  const AuthInProgress();
}

class AuthFailure extends AuthState {
  final String errorMsg;

  const AuthFailure(this.errorMsg);
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

extension AuthStateExtension on AuthState {
  bool get canSubmitLogin => this is AuthInitial || this is AuthFailure;
}
