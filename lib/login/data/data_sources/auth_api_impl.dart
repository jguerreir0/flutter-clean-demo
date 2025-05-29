import 'package:dio/dio.dart';
import 'package:mydemo/login/data/data_sources/abstract_auth_api.dart';
import 'package:mydemo/login/domain/models/user_model.dart';

class AuthApiImpl extends AbstractAuthApi {
  AuthApiImpl(this.dio);

  final Dio dio;

  @override
  Future<UserModel> login(String username, String password) {
    try {
      return dio.post('auth/login', data: {
        'username': username,
        'password': password,
      }).then((response) {
        if (response.statusCode == 200) {
          return UserModel.fromJson(response.data);
        } else {
          throw Exception('Failed to login');
        }
      });
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}
