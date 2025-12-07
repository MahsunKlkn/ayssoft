class CartProduct {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory CartProduct.fromJson(Map<String, dynamic> map) {
  return CartProduct(
    id: map['id'] as int,
    title: map['title'] as String,
    price: map['price'].toDoubleSafe(),
    quantity: map['quantity'] as int,
    total: map['total'].toDoubleSafe(),
    discountPercentage: map['discountPercentage'].toDoubleSafe(),
    discountedTotal: map['discountedTotal'].toDoubleSafe(),
    thumbnail: map['thumbnail'] as String,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'total': total,
      'discountPercentage': discountPercentage,
      'discountedTotal': discountedTotal,
      'thumbnail': thumbnail,
    };
  }
}
