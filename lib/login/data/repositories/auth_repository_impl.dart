import 'package:mydemo/login/domain/models/user_model.dart';

import '../../domain/repositories/abstract_auth_repository.dart';
import '../data_sources/abstract_auth_api.dart';

class AuthRepositoryImpl extends AbstractAuthRepository {
  AuthRepositoryImpl(this.authApi);

  final AbstractAuthApi authApi;

  @override
  Future<UserModel> login(String username, String password) =>
      authApi.login(username, password);
}
