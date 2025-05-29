import 'package:mydemo/login/domain/models/user_model.dart';

abstract class AbstractAuthRepository {
  Future<UserModel> login(String username, String password);
}
