import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListWidget extends ConsumerStatefulWidget {
  const CategoryListWidget({super.key});

  @override
  ConsumerState<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends ConsumerState<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    final String? selectedCategory = ref.watch(selectedCategoryProvider);

    final productState = ref.watch(productNotifierProvider);
    final theme = Theme.of(context);

    if (productState.isCategoryLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 120.0.h),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 5.3)),
      );
    }

    if (productState.categoryError != null) {
      return Padding(
        padding: EdgeInsets.all(48.0.w),
        child: Text(
          productState.categoryError!,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.error,
            fontSize: 48.sp,
          ),
        ),
      );
    }

    final categoriesToShow = productState.categories
        .where((cat) => cat != 'Tüm Ürünler')
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: 48.0.h, bottom: 82.0.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 32.0.w),
        child: Row(
          children: categoriesToShow.map((category) {
            final isSelected = selectedCategory == category;

            final Color unselectedBorderColor = Colors.grey.shade300;
            final Color unselectedBgColor = Colors.white;

            return Padding(
              padding: EdgeInsets.only(right: 32.0.w),
              child: Material(
                color: isSelected ? theme.primaryColor : unselectedBgColor,
                borderRadius: BorderRadius.circular(28.r),
                elevation: isSelected ? 16 : 0,
                shadowColor: isSelected
                    ? theme.primaryColor.withOpacity(0.7)
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final newCategory = isSelected ? null : category;
                    ref.read(selectedCategoryProvider.notifier).state = newCategory;
                    ref
                        .read(productNotifierProvider.notifier)
                        .applyCategoryFilter(newCategory);

                    print(
                        'Seçilen Kategori (Notifiera Giden): $newCategory',
                    );
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 80.w,
                      vertical: 42.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? theme.primaryColor
                            : unselectedBorderColor,
                        width: 4.0.w,
                      ),
                    ),
                    child: Text(
                      category,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 40.sp,
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}