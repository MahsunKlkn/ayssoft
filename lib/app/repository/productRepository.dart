import 'package:ayssoft/app/data/model/productList.dart';
import 'package:ayssoft/app/data/service/Base/productBase.dart';
import 'package:ayssoft/app/repository/Base/productBase.dart';

class ProductRepository implements ProductBaseRepository {
  // ProductBase (Service arayüzü) inject ediliyor.
  final ProductBase _productService;
  ProductRepository(this._productService);

  @override
  Future<ProductListResponse?> fetchProducts() async {
    try {
      final response = await _productService.getProducts();
      
      if (response == null) {
        print('⚠️ UYARI [Repository]: ProductService null döndü.');
        return null;
      }

      if (response.products != null && response.products!.isNotEmpty) {
        print(
          '✅ BAŞARILI [Repository]: Ürünler başarıyla getirildi. Toplam: ${response.products!.length}',
        );
        print('İlk Ürün: ${response.products!.first.title}');
      } else {
        print('⚠️ UYARI [Repository]: Ürün listesi boş.');
      }

      return response;
    } catch (e) {
      print('❌ HATA [Repository]: Ürünler getirilirken hata: $e');
      return null;
    }
  }

  @override
  Future<List<String>?> fetchCategories() async {
    try {
      final categories = await _productService.getCategories();
      
      if (categories != null && categories.isNotEmpty) {
        print(
          '✅ BAŞARILI [Repository]: Kategoriler başarıyla çekildi. Toplam kategori sayısı: ${categories.length}',
        );
        print('İlk Kategori Adı: ${categories.first}');
      } else {
        print(
          '⚠️ UYARI [Repository]: Kategori çekme başarılı, ancak kategori listesi null veya boş.',
        );
      }
      return categories;
    } catch (e) {
      print(
        '❌ KRİTİK HATA [Repository]: Kategori çekerken hata oluştu: $e',
      );
      return null;
    }
  }
}