import 'dart:convert';

import 'package:ayssoft/app/data/model/user.dart';
import 'package:hive/hive.dart';

final class AuthCacheManager {
  static final AuthCacheManager instance = AuthCacheManager._internal();
  AuthCacheManager._internal();
  final String _boxName = 'authBox';
  final String _tokenKey = 'access_token';
  final String _refreshTokenKey = 'refresh_token';
  final String _userKey = 'user_data';
  final String _isLoggedInKey = 'is_logged_in';
  final String _userIdKey = 'user_id';
  Box get _box => Hive.box(_boxName);

  Map<dynamic, dynamic> getDebugBoxMap() {
    return _box.toMap();
  }

  bool isUserLoggedIn() {
    return getAccessToken() != null;
  }

  Future<void> saveUser(UserModel user) async {
    Map<String, dynamic> rawJson = user.toJson();
    rawJson.remove('accessToken');
    rawJson.remove('refreshToken');
    String userJson = jsonEncode(rawJson);
    await _box.put(_userKey, userJson);
  }

  UserModel? getUser() {
    String? userJson = _box.get(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> saveAuthData(
    String accessToken,
    String refreshToken,
    int userId,
  ) async {
    await _box.put(_tokenKey, accessToken);
    await _box.put(_refreshTokenKey, refreshToken);
    await _box.put(_userIdKey, userId);
    await _box.put(_isLoggedInKey, true);
  }

  String? getAccessToken() {
    return _box.get(_tokenKey);
  }

  String? getRefreshToken() {
    return _box.get(_refreshTokenKey);
  }

  int? getUserId() {
    return _box.get(_userIdKey);
  }

  @override
  Future<void> signOut() async {
    await _box.delete(_tokenKey);
    await _box.delete(_refreshTokenKey);
    await _box.delete(_userKey);
    await _box.delete(_userIdKey); // 🆕 ID siliniyor
    await _box.put(_isLoggedInKey, false);
  }
}
