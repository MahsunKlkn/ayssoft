import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/core/storage/auth.dart';
import 'package:ayssoft/app/manager/provider/product.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/category-list.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/hero-banner.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/logout-btn.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/product-list.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/product-search-bar.dart';
import 'package:ayssoft/app/ui/screens/Home/widgets/section-title.dart';
import 'package:ayssoft/app/ui/screens/Login/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.95) {
      ref.read(productNotifierProvider.notifier).loadNextProducts();
    }
  }

  Future<void> _signOutAndNavigate() async {
    await AuthCacheManager.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.grey50,
        title: Text(widget.title),
        actions: <Widget>[LogoutButton(onPressed: _signOutAndNavigate)],
      ),
      body: CustomScrollView( 
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: 20.h),
          ),
          const SliverToBoxAdapter(
            child: HeroBanner(),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(title: "Birlikte Arayalım"),
          ),
          const SliverToBoxAdapter(
            child: ProductSearchBar(),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(title: "Kategoriler"),
          ),
          const SliverToBoxAdapter( 
             child: CategoryListWidget(),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(title: "Ürünler"),
          ),
          const ProductListWidget(),
          if (productState.isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.0, top: 16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}