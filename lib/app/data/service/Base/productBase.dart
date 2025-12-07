import '../../model/productList.dart';

abstract class ProductBase {
  Future<ProductListResponse?> getProducts();
  Future<List<String>?> getCategories();
}
