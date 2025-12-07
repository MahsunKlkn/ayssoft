import 'package:hive/hive.dart';

part 'cartProduct.g.dart';

@HiveType(typeId: 0)  // benzersiz id
class CartProduct {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final double total;

  @HiveField(5)
  final double discountPercentage;

  @HiveField(6)
  final double discountedTotal;

  @HiveField(7)
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
}
