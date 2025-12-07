import 'package:ayssoft/app/data/model/product.dart';

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final bool allProductsLoaded;
  final String? errorMessage;
  final List<String> categories;
  final bool isCategoryLoading;
  final String? categoryError;

  ProductState({
    this.products = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.allProductsLoaded = false, 
    this.errorMessage,
    this.categories = const [],
    this.isCategoryLoading = true,
    this.categoryError,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLoadingMore,
    bool? allProductsLoaded,
    String? errorMessage,
    List<String>? categories,
    bool? isCategoryLoading,
    String? categoryError,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      allProductsLoaded: allProductsLoaded ?? this.allProductsLoaded,
      errorMessage: errorMessage,
      categories: categories ?? this.categories,
      isCategoryLoading: isCategoryLoading ?? this.isCategoryLoading,
      categoryError: categoryError,
    );
  }
}