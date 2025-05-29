import 'package:mydemo/login/domain/models/user_model.dart';
import 'package:mydemo/login/domain/repositories/abstract_auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this.authRepository);

  final AbstractAuthRepository authRepository;

  Future<UserModel> call(String username, String password) async =>
      await authRepository.login(username, password);
}
