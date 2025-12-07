import 'package:ayssoft/app/manager/state/productState.dart';
import 'package:ayssoft/app/repository/Base/productBase.dart';
import 'package:ayssoft/app/data/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductBaseRepository _repository;
  static const int _productsPerPage = 6;
  
  List<Product>? _allProductsCache;
  List<Product>? _filteredProductsCache; 
  final Ref _ref; 

  ProductNotifier(this._repository, this._ref) : super(ProductState());

  Future<void> loadProducts() async {
    _allProductsCache = null; 
    _filteredProductsCache = null;

    state = state.copyWith(
      products: [], 
      isLoading: true, 
      isLoadingMore: false,
      allProductsLoaded: false, 
      errorMessage: null,
      categories: [],
      isCategoryLoading: true, 
      categoryError: null,
    );
    await Future.wait([
      _fetchAndCacheAllProducts(),
      _loadCategories(),
    ]);
    _filteredProductsCache = _allProductsCache; 
    _paginateProducts(); 
  }
  Future<void> applyFilter({String? category, String? searchQuery}) async {
    if (_allProductsCache == null) {
      await _fetchAndCacheAllProducts();
    }
    
    if (_allProductsCache == null) return;

    state = state.copyWith(
      isLoading: true, 
      products: [],
      allProductsLoaded: false, 
      isLoadingMore: false,
    );
    List<Product> categorizedProducts;
    if (category == null || category == 'Tüm Ürünler') {
      categorizedProducts = _allProductsCache!;
    } else {
      categorizedProducts = _allProductsCache!
          .where((product) => product.category == category)
          .toList();
    }
    final query = searchQuery?.trim().toLowerCase();
    if (query != null && query.isNotEmpty) {
      _filteredProductsCache = categorizedProducts
          .where((product) =>
              product.title.toLowerCase().contains(query) 
          )
          .toList();
    } else {
      _filteredProductsCache = categorizedProducts;
    }
    
    await Future.delayed(const Duration(milliseconds: 300));
    _paginateProducts();
  }
  Future<void> applyCategoryFilter(String? category) async {
    final currentSearchQuery = _ref.read(searchQueryProvider);
    await applyFilter(category: category, searchQuery: currentSearchQuery);
  }
  Future<void> applySearchFilter(String searchQuery) async {
    final currentCategory = _ref.read(selectedCategoryProvider);
    await applyFilter(category: currentCategory, searchQuery: searchQuery);
  }


  Future<void> _loadCategories() async {
    try {
      final categoryList = await _repository.fetchCategories();
      final updatedCategories = ['Tüm Ürünler', ...?categoryList];
      
      state = state.copyWith(
        categories: updatedCategories,
        isCategoryLoading: false,
        categoryError: null,
      );
      print('✅ BAŞARILI [Notifier]: Kategori sayısı: ${updatedCategories.length}');
      
    } catch (e) {
      print('❌ HATA [Notifier]: Kategoriler yüklenirken hata oluştu: $e');
      state = state.copyWith(
        isCategoryLoading: false,
        categories: ['Tüm Ürünler'], 
        categoryError: 'Kategoriler yüklenemedi. Lütfen tekrar deneyin.',
      );
    }
  }

  Future<void> loadNextProducts() async {
    if (state.allProductsLoaded || state.isLoadingMore || _filteredProductsCache == null) {
      return; 
    }
    
    state = state.copyWith(isLoadingMore: true);

    _paginateProducts();
  }

  Future<void> _fetchAndCacheAllProducts() async {
    try {
      final response = await _repository.fetchProducts();
      
      if (response != null && response.products != null) {
        _allProductsCache = response.products!; 
        state = state.copyWith(errorMessage: null); 
      } else {
        _allProductsCache = [];
        state = state.copyWith(
          isLoading: false,
          allProductsLoaded: true, 
          errorMessage: "Ürünler yüklenemedi veya liste boş.",
        );
      }
    } catch (e) {
      _allProductsCache = [];
      state = state.copyWith(
        isLoading: false,
        allProductsLoaded: true, 
        errorMessage: e.toString(), 
      );
    }
  }
  
  void _paginateProducts() async { 
    if (_filteredProductsCache == null) {
      if (!state.isLoading) loadProducts();
      return; 
    }
    await Future.delayed(const Duration(milliseconds: 500)); 

    final productsToPaginate = _filteredProductsCache!;
    
    final startIndex = state.products.length; 
    final endIndex = (startIndex + _productsPerPage).clamp(0, productsToPaginate.length);
    final newProducts = productsToPaginate.sublist(startIndex, endIndex);
    final updatedProducts = [...state.products, ...newProducts];
    
    final isDone = updatedProducts.length >= productsToPaginate.length;

    state = state.copyWith(
      products: updatedProducts,
      isLoading: false, 
      isLoadingMore: false,
      allProductsLoaded: isDone, 
    );
  }
}