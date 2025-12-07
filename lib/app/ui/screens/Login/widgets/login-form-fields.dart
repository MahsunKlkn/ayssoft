import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _obscurePassword = true;

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.65),
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.black87),
      suffixIcon: suffix,
      labelStyle: TextStyle(fontSize: 40.sp, color: Colors.black87),
      hintStyle: TextStyle(fontSize: 40.sp, color: Colors.black54),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.9), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),

      contentPadding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
          decoration: _inputDecoration(
            label: 'Kullanıcı Adı',
            hint: 'örn: emilys',
            icon: Icons.person,
          ),
        ),

        SizedBox(height: 50.h),
        TextFormField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          decoration: _inputDecoration(
            label: 'Şifre',
            hint: 'örn: emilyspass',
            icon: Icons.lock,
            suffix: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.black87,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),

        SizedBox(height: 30.h),
        Row(
          children: [
            Checkbox(
              value: widget.rememberMe,
              onChanged: widget.onRememberMeChanged,
            ),
            Text('Beni Hatırla', style: TextStyle(fontSize: 35.sp)),
          ],
        ),

        SizedBox(height: 80.h),
      ],
    );
  }
}
