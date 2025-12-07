import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListWidget extends ConsumerWidget { 
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productNotifierProvider);

    if (productState.isLoading && productState.products.isEmpty) {
      return SliverToBoxAdapter( 
        child: SizedBox(
          height: 110.h,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    if (productState.errorMessage != null && productState.products.isEmpty) {
      return SliverToBoxAdapter( 
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Center(child: Text('Hata: ${productState.errorMessage}')),
        ),
      );
    }
    if (productState.products.isEmpty && !productState.isLoading) {
      return SliverToBoxAdapter( 
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: const Center(child: Text('Ürün bulunamadı.')),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = productState.products[index]; 
            return ProductCard(product: product);
          },
          childCount: productState.products.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.75, 
          crossAxisSpacing: 10.w, 
          mainAxisSpacing: 10.h,  
        ),
      ),
    );
  }
}