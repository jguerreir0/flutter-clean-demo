import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydemo/login/presentation/storage/auth_storage.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecases/login_use_case.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.loginUseCase,
    this.authStorage,
  ) : super(const AuthInitial()) {
    on<OnAuthCheckRequested>(_onAuthCheckRequested);
    on<OnLogin>(_onLogin);
    on<OnLogout>(_onLogout);
  }
  final LoginUseCase loginUseCase;
  final AuthStorage authStorage;

  Future<void> _onAuthCheckRequested(
    OnAuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final storageHasSession = await authStorage.hasSession();

    if (storageHasSession) {
      emit(const AuthSuccess());
    } else {
      emit(const AuthInitial());
    }
  }

  Future<void> _onLogin(
    OnLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInProgress());
    try {
      final user = await loginUseCase(event.username, event.password);
      await _saveSession(user);
      emit(const AuthSuccess());
    } catch (e) {
      emit(const AuthFailure('Currently unavailable, try again later'));
    }
  }

  Future<void> _onLogout(
    OnLogout event,
    Emitter<AuthState> emit,
  ) async {
    await authStorage.clearSession();
    emit(const AuthInitial());
  }

  Future<void> _saveSession(
    UserModel user,
  ) async =>
      authStorage.saveSession(
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
      );
}
