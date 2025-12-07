import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSearchBar extends ConsumerStatefulWidget {
  const ProductSearchBar({super.key});
  @override
  ConsumerState<ProductSearchBar> createState() => _ProductSearchBarState();
}
class _ProductSearchBarState extends ConsumerState<ProductSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }
  void _onTextChanged() {
    final newText = _controller.text;
    setState(() {
      _isSearching = newText.isNotEmpty;
    });
    ref.read(searchQueryProvider.notifier).state = newText;
    ref.read(productNotifierProvider.notifier).applySearchFilter(newText);
    print('Arama Sorgusu: $newText');
  }
  void _clearSearch() {
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 36.w, 
        vertical: 18.h,   
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) {
          print('Aranan (Enter): $value');
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 24.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.w),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const Icon(Icons.search, color: Colors.grey),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 70.w), 
          suffixIcon: _isSearching
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: _clearSearch,
                )
              : null,
          hintText: "Ürün, marka veya kategori ara...",
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 32.sp,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }
}