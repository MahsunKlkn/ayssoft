import 'package:hive/hive.dart';
import 'cartProduct.dart';

part 'cart.g.dart';

@HiveType(typeId: 1)
class Cart {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<CartProduct> products;

  @HiveField(2)
  final double total;

  @HiveField(3)
  final double discountedTotal;

  @HiveField(4)
  final int userId;

  @HiveField(5)
  final int totalProducts;

  @HiveField(6)
  final int totalQuantity;

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });
}
