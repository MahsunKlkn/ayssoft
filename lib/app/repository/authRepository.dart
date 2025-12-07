import 'package:ayssoft/app/core/storage/auth.dart';
import 'package:ayssoft/app/repository/Base/authBase.dart';
import 'package:dio/dio.dart';

import '../data/model/user.dart';
import '../data/service/auth.dart';

class AuthRepository implements IAuthRepository {
  final AuthService _service;
  final AuthCacheManager _cacheManager = AuthCacheManager.instance;
  AuthRepository({required AuthService service}) : _service = service;
  
 @override
 bool get isUserLoggedIn => _cacheManager.isUserLoggedIn();
  
  @override
  // 🚀 Yeni Parametre Eklendi: rememberMe
  Future<UserModel?> login(String username, String password, {bool rememberMe = false}) async {
    try {
      final response = await _service.login(username, password);
      
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(
          response.data,
        );
        
        if (user.accessToken != null) {
          if (rememberMe) {
            await _cacheManager.saveAuthData(
              user.accessToken!,
              user.refreshToken ?? '',
              user.id,
            );
            await _cacheManager.saveUser(user);
            
            print('✅ Repo: Giriş Başarılı ve Kalıcı Kayıt Yapıldı.');
            print(
              '📦 HIVE KUTU DURUMU (Debug): ${_cacheManager.getDebugBoxMap()}',
            );
          } else {
            print('✅ Repo: Giriş Başarılı, Kalıcı Kayıt YAPILMADI (Remember Me kapalı).');
          }
          
          return user;
        }
      }
      return null;
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      print('❌ Repo: Login Hatası - $errorMessage');
      throw Exception(errorMessage);
    } catch (e) {
      print('❌ Repo: Beklenmedik Hata - $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await _service.getCurrentUser();

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      print('❌ Repo: GetUser Hatası - ${e.message}');
      return null;
    }
  }

  @override
  Future<UserModel?> refreshToken(String oldRefreshToken) async {
    try {
      final response = await _service.refreshToken(oldRefreshToken);
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        print('🔄 Repo: Token Yenilendi');
        return user;
      }
      return null;
    } catch (e) {
      print('❌ Repo: Refresh Token Hatası - $e');
      return null;
    }
  }
}