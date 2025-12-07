// productList.dart
import 'product.dart';

class ProductListResponse {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductListResponse({this.products, this.total, this.skip, this.limit});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? productListJson = json['products'];

    List<Product>? productsList;
    if (productListJson != null) {
      productsList = productListJson
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return ProductListResponse(
      products: productsList,
      total: json['total'] as int?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
    );
  }
}