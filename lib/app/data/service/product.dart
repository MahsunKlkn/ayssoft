import 'package:ayssoft/app/data/service/Base/productBase.dart';
import 'package:dio/dio.dart';
import '../../core/config/dio.dart';
import '../../core/config/endpoint.dart';

class ProductService implements ProductBase {
  final Dio _dio = DioClient.instance;

  @override
  Future<Map<String, dynamic>?> getProducts() async {
    try {
      final response = await _dio.get(ApiPaths.products);
      
      if (response.data != null) {
        return response.data as Map<String, dynamic>?;
      }
      return null;
    } on DioException {
      return null;
    } catch (e) {
      print('❌ Ürünler parse edilirken hata: $e');
      return null;
    }
  }

  @override
  Future<List<String>?> getCategories() async {
    try {
      final response = await _dio.get(ApiPaths.productCategories);
      
      if (response.data is List) {
        return (response.data as List).cast<String>();
      }
      return null;
    } on DioException {
      return null;
    } catch (e) {
      print('❌ Kategoriler parse edilirken hata: $e');
      return null;
    }
  }
}
