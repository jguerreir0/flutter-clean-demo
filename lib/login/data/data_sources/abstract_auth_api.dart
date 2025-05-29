import '../../domain/models/user_model.dart';

abstract class AbstractAuthApi {
  Future<UserModel> login(String username, String password);
}
