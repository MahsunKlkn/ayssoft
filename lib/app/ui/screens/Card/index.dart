import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/manager/provider/cart.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/cart-item-compact.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/checout-btn.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/delivery-info-card.dart';
import 'package:ayssoft/app/ui/screens/Card/widget/delivery-info-stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final cart = cartState.cart;
    final cartProducts = cart?.products ?? [];

    if (cartState.isLoading) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: _buildAppBar(context, AppColors.primary),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: _buildAppBar(context, AppColors.primary),
      body: Column(
        children: [
          DeliveryInfoStepper(
            step1Label: "Sepet",
            step2Label: "Teslimat",
            step3Label: "Ödeme",
            primaryColor: AppColors.primary,
          ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: cartProducts.isEmpty
                  ? Center(
                      child: Text(
                        "😔 Sepetinizde ürün bulunmamaktadır.",
                        style: TextStyle(fontSize: 50.sp, color: Colors.grey),
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DeliveryInfoCard(primaryColor: AppColors.primary),
                        ...cartProducts
                            .map(
                              (product) => CartItemCompact(
                                product: product,
                                primaryColor: AppColors.primary,
                                // Adet değiştirme işlevi kaldırıldı
                                onRemove: () =>
                                    cartNotifier.removeProduct(product.id),
                              ),
                            )
                            .toList(),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 25.h,
                            horizontal: 25.w,
                          ),
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: 45.sp,
                            ),
                            label: Text(
                              "Alışverişe Devam Et",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 25.h),
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: cartProducts.isEmpty
          ? null
          : CheckoutButtonSection(
              total: cart?.total ?? 0,
              discountedTotal: cart?.discountedTotal ?? 0,
              totalProducts: cart?.totalProducts ?? 0,
              primaryColor: AppColors.primary,
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Color primaryColor) {
    return AppBar(
      backgroundColor: AppColors.primary,
      //leading: IconButton(
      //  icon: Icon(Icons.arrow_back, color: Colors.white, size: 60.sp),
      //  onPressed: () => Navigator.of(context).pop(),
      //),
      title: Text(
        "Sepetim",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 50.sp,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: Center(
            child: Text(
              "Mağaza Adı",
              style: TextStyle(fontSize: 40.sp, color: Colors.white70),
            ),
          ),
        ),
      ],
      elevation: 0,
    );
  }
}
