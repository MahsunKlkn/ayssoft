

import 'package:ayssoft/app/data/model/cartProduct.dart';

class Cart {
  final int id;
  final List<CartProduct> products;
  final double total; // Sepetteki tüm ürünlerin indirimsiz toplamı
  final double discountedTotal; // Sepetteki tüm ürünlerin indirimli toplamı
  final int userId;
  final int totalProducts; // Sepetteki farklı ürün sayısı (4)
  final int totalQuantity; // Sepetteki toplam ürün adedi (15)

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  // JSON'dan Cart nesnesi oluşturmak için fabrika metodu
  factory Cart.fromJson(Map<String, dynamic> json) {
    // 1. Ürün listesini dönüştürme
    final List<dynamic> productListJson = json['products'] as List<dynamic>;
    final List<CartProduct> productsList = productListJson
        .map((item) => CartProduct.fromJson(item as Map<String, dynamic>))
        .toList();

    // 2. Ana sepet modelini oluşturma
    return Cart(
      id: json['id'] as int,
      products: productsList,
      total: (json['total'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
      userId: json['userId'] as int,
      totalProducts: json['totalProducts'] as int,
      totalQuantity: json['totalQuantity'] as int,
    );
  }
}