import 'package:ayssoft/app/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalInfo extends StatelessWidget {
  final Product product;
  const AdditionalInfo({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teslimat ve Garanti Bilgileri',
          style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        _infoRow(
          Icons.local_shipping,
          'Kargo: ',
          product.shippingInformation,
          Colors.blue.shade700,
        ),
        _infoRow(
          Icons.security,
          'Garanti: ',
          product.warrantyInformation,
          Colors.orange.shade700,
        ),
        _infoRow(
          Icons.receipt_long,
          'İade: ',
          product.returnPolicy,
          product.returnPolicy == 'No return policy'
              ? Colors.red.shade700
              : Colors.green.shade700,
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String title, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 55.sp, color: color),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 45.sp, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
