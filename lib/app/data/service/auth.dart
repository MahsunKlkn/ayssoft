import 'package:dio/dio.dart';
import '../../core/config/dio.dart';
import '../../core/config/endpoint.dart';

class AuthService {
  final Dio _dio = DioClient.instance;
  Future<Response> login(String username, String password) async {
    return await _dio.post(
      ApiPaths.auth, 
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 30,
      },
    );
  }

  Future<Response> getCurrentUser() async {
    return await _dio.get(ApiPaths.me);
  }

  Future<Response> refreshToken(String oldRefreshToken) async {
    return await _dio.post(
      ApiPaths.refresh,
      data: {
        'refreshToken': oldRefreshToken,
        'expiresInMins': 30,
      },
    );
  }
}