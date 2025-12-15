
 import 'package:flutter/material.dart';

import '../../../../core/utils/AppValidators.dart';

class FormLogin extends StatefulWidget {
  FormLogin({super.key});

  @override
  State<FormLogin> createState() => _LoginFormState();
}

class _LoginFormState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  void login({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    if (_formKey.currentState!.validate()) {
      try {
    
      } catch (e) {
        print("catch $e");
      }
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
            return AppValidators.email(value);
            },
          ),
          const SizedBox(height: 16),

          // 🔒 حقل الباسورد
          TextFormField(
            controller: _passwordController,
            onFieldSubmitted: (value) => login(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              return AppValidators.password(value);
            },
          ),
          const SizedBox(height: 24),

          // 🔘 زر تسجيل الدخول
          ElevatedButton(
            onPressed: () {
              login(
                emailController: _emailController,
                passwordController: _passwordController,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
