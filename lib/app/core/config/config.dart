import 'package:ayssoft/app/core/utils/enum/environment.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

final class AppConfig {
  late final String apiBaseUrl;

  static final AppConfig instance = AppConfig._internal();
  AppConfig._internal();

  static void setup(Environment environment) {
    instance.apiBaseUrl = _getBaseUrl(environment);

    if (kDebugMode) {
      print('🚀 AppConfig Başlatıldı: ${environment.name}');
      print('✅ API Base URL: ${instance.apiBaseUrl}');
    }
  }

  static String _getBaseUrl(Environment environment) {
    switch (environment) {
      case Environment.prod:
        return 'https://dummyjson.com';
      case Environment.dev:
        return 'https://dummyjson.com';
    }
  }
}

