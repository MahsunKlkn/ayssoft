import 'package:ayssoft/app/data/service/Base/productBase.dart';
import 'package:dio/dio.dart';
import '../../core/config/dio.dart'; // DioClient'ın olduğu varsayılır
import '../../core/config/endpoint.dart'; // ApiPaths'in olduğu varsayılır

class ProductService implements ProductBase {
  final Dio _dio = DioClient.instance;
  @override
  Future<Map<String, dynamic>?> getProducts() async {
    try {
      final response = await _dio.get(ApiPaths.products);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<String>?> getCategories() async {
    try {
      final response = await _dio.get(ApiPaths.productCategories);

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List).cast<String>();
        }
        return null;
      }
      return null;
    } on DioException catch (e) {
      print('Kategori listesi çekerken Dio hatası: $e');
      return null;
    } catch (e) {
      print('Kategori listesi çekerken beklenmeyen hata: $e');
      return null;
    }
  }
}
