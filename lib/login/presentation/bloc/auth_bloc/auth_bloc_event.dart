part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class OnAuthCheckRequested extends AuthEvent {
  const OnAuthCheckRequested();
}

class OnLogin extends AuthEvent {
  final String username;
  final String password;

  const OnLogin(this.username, this.password);
}

class OnLogout extends AuthEvent {
  const OnLogout();
}
