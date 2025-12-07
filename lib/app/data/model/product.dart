// product.dart
import 'dimension.dart';
import 'meta.dart';
import 'review.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus; 
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<String> tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    final List<String> images = (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
    final List<dynamic> reviewsJson = json['reviews'] ?? [];
    final List<Review> reviews = reviewsJson
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList();
    return Product(
      id: json['id'] as int,
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      tags: tags,
      brand: (json['brand'] ?? '') as String,
      sku: (json['sku'] ?? '') as String,
      weight: json['weight'] as int,
      dimensions: Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      reviews: reviews,

      warrantyInformation: (json['warrantyInformation'] ?? '') as String,
      shippingInformation: (json['shippingInformation'] ?? '') as String,
      availabilityStatus: (json['availabilityStatus'] ?? '') as String,
      returnPolicy: (json['returnPolicy'] ?? '') as String,
      minimumOrderQuantity: json['minimumOrderQuantity'] as int,
      images: images,
      thumbnail: (json['thumbnail'] ?? '') as String,
    );
  }
}