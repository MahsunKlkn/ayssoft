import 'package:ayssoft/app/data/service/product.dart';
import 'package:ayssoft/app/manager/riverpod/product.dart';
import 'package:ayssoft/app/manager/state/productState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ayssoft/app/repository/productRepository.dart';
import 'package:flutter_riverpod/legacy.dart';

final productServiceProvider = Provider((ref) {
  return ProductService(); 
});


final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final service = ref.watch(productServiceProvider);
  return ProductRepository(service); 
});
final productNotifierProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  final notifier = ProductNotifier(repository, ref);
  notifier.loadProducts(); 
  return notifier;
});
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');