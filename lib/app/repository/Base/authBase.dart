import '../../data/model/user.dart';

abstract class IAuthRepository {
  Future<UserModel?> login(String username, String password);
  Future<UserModel?> getCurrentUser();
  Future<UserModel?> refreshToken(String oldRefreshToken);
}