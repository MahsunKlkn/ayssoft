import 'package:ayssoft/app/common/root-shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../Login/index.dart';
import '../../../data/service/auth.dart';
import '../../../repository/authRepository.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final AuthRepository _authRepository;
  bool _isNavigationDone = false;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(service: AuthService());
  }

  Future<bool> _checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _authRepository.isUserLoggedIn;
  }
  void _navigateToNextScreen(bool isLoggedIn) {
    if (_isNavigationDone) return;
    _isNavigationDone = true;
    final Widget nextScreen = isLoggedIn 
        ? const RootShell() 
        : const LoginPage(); 

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final isLoggedIn = snapshot.data ?? false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToNextScreen(isLoggedIn);
            });
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'lib/app/public/lottie/loading.json',
                  width: 600.w,
                  height: 600.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}