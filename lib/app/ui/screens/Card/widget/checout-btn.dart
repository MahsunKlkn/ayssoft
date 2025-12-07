import 'package:ayssoft/app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutButtonSection extends StatelessWidget {
  final double total;
  final double discountedTotal;
  final int totalProducts;
  final Color primaryColor;

  const CheckoutButtonSection({
    required this.total,
    required this.discountedTotal,
    required this.totalProducts,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    // Toplam fiyatta indirim olup olmadığını kontrol eder
    final bool hasDiscount = total != discountedTotal && discountedTotal != 0.0;
    
    // displayTotal artık sadece indirimli fiyatı tutar
    final displayTotal = discountedTotal != 0.0 ? discountedTotal : total;
    
    return Container(
      padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 50.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10.w, offset: Offset(0, -3.w)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Toplam ($totalProducts ürün)",
                    style: TextStyle(fontSize: 40.sp, color: Colors.black),
                  ),
                  Text(
                    "KDV ve Kargo ücreti dahil",
                    style: TextStyle(fontSize: 36.sp, color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () { /* Detaylar aksiyonu */ },
                    child: Text("Detaylar", style: TextStyle(fontSize: 36.sp, color: AppColors.primary)),
                  )
                ],
              ),
              
              // Fiyatların Gösterildiği Kısım (DEĞİŞTİRİLDİ)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Orijinal Toplam Fiyat (İndirim varsa üstü çizili gösterilir)
                  if (hasDiscount) 
                    Text(
                      "${total.toStringAsFixed(2)} TL",
                      style: TextStyle(
                        fontSize: 40.sp, // Daha küçük ve gri
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                      ),
                    ),
                  // Nihai Ödenecek Fiyat (Vurgulu)
                  Text(
                    "${displayTotal.toStringAsFixed(2)} TL",
                    style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              // DEĞİŞİKLİK BİTİŞİ
            ],
          ),
          
          SizedBox(height: 25.h),
          
          ElevatedButton(
            onPressed: () {
              // Ödeme/Teslimat sayfasına yönlendirme
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 35.h),
              minimumSize: Size(double.infinity, 70.h), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
            ),
            child: Text(
              "Ödeme Sayfasına Geç",
              style: TextStyle(fontSize: 45.sp, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}