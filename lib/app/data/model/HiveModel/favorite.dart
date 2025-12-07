import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 2) 
class FavoriteProduct {
  @HiveField(0)
  final int id; 

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price; 

  @HiveField(3)
  final String thumbnail;

  @HiveField(4)
  final double? rating;

  @HiveField(5)
  final DateTime addedToFavoritesAt; 

  FavoriteProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.rating,
    required this.addedToFavoritesAt,
  });
}