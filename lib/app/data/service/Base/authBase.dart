import '../../model/user.dart';

abstract class AuthBase {
  Future<UserModel?> login(String username, String password);
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> refreshToken(String oldRefreshToken);
}