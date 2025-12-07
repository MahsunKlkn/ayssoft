import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/config.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }
  static Dio _createDio() {
    final options = BaseOptions(
      baseUrl: AppConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final statusCode = response.statusCode ?? 0;
          
          if (statusCode >= 200 && statusCode < 300) {
            print('✅ Başarılı: ${response.requestOptions.path} - Status: $statusCode');
          } else if (statusCode >= 300 && statusCode < 400) {
            print('🔄 Yönlendirme: ${response.requestOptions.path} - Status: $statusCode');
          }
          
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          final statusCode = error.response?.statusCode;
          final path = error.requestOptions.path;
          
          switch (statusCode) {
            case 400:
              print('❌ Hatalı İstek (400): $path - ${error.message}');
              break;
            case 401:
              print('🔐 Yetkisiz Erişim (401): $path - Oturum açmanız gerekiyor');
              break;
            case 403:
              print('🚫 Erişim Engellendi (403): $path - Yetkiniz yok');
              break;
            case 404:
              print('🔍 Bulunamadı (404): $path - Kaynak bulunamadı');
              break;
            case 408:
              print('⏱️ Zaman Aşımı (408): $path');
              break;
            case 429:
              print('🚦 Çok Fazla İstek (429): $path - Lütfen bekleyin');
              break;
            case 500:
              print('💥 Sunucu Hatası (500): $path - Sunucu hatası');
              break;
            case 502:
              print('🌐 Kötü Ağ Geçidi (502): $path');
              break;
            case 503:
              print('⚠️ Hizmet Kullanılamıyor (503): $path');
              break;
            case 504:
              print('⏰ Ağ Geçidi Zaman Aşımı (504): $path');
              break;
            default:
              if (statusCode != null) {
                print('⚠️ HTTP Hatası ($statusCode): $path - ${error.message}');
              } else {
                print('🔌 Bağlantı Hatası: $path - ${error.message}');
              }
          }
          
          return handler.next(error);
        },
      ),
    );
    
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true, 
          requestHeader: false,
          responseHeader: false,
          error: true,
          logPrint: (object) => print('📡 LOG: $object'),
        ),
      );
    }

    print('🔧 DioClient - Global instance oluşturuldu');
    return dio;
  }
  static void reset() {
    _instance = null;
    print('🔄 DioClient - Instance reset edildi');
  }
}