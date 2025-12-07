import 'package:ayssoft/app/core/config/config.dart';
import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/core/utils/enum/environment.dart' show Environment;
import 'package:ayssoft/app/data/model/HiveModel/cart.dart';
import 'package:ayssoft/app/data/model/HiveModel/cartProduct.dart';
import 'package:ayssoft/app/data/model/HiveModel/favorite.dart';
import 'package:ayssoft/app/ui/screens/Landing/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  
  Hive.registerAdapter(CartProductAdapter());
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(FavoriteProductAdapter());
  
  
 await Hive.openBox('authBox');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  AppConfig.setup(Environment.dev);
  runApp( ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400), 
      minTextAdapt: true, 
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: child, 
        );
      },
      child: const LandingPage(),
    );
  }
}