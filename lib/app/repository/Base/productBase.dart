import 'package:ayssoft/app/data/model/productList.dart';

abstract class ProductBaseRepository {
  Future<ProductListResponse?> fetchProducts( );
  Future<List<String>?> fetchCategories();
}
