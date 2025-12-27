  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
  import '../../../../core/utils/AppValidators.dart';
 
class FormLogin extends StatefulWidget {
  FormLogin({super.key});

  @override
  State<FormLogin> createState() => _LoginFormState();
}

class _LoginFormState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  void login() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_formKey.currentState!.validate()) {
          try {
            await context.read<AuthCubit>().login(
                    email: _emailController.text.trim(),
                     password: _passwordController.text.trim(),
                );setState(() {
               _emailController.clear();
           _passwordController.clear();

                });
           
          } catch (e) {
            print("Error: $e");
          }
        }
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
            onFieldSubmitted: (value) => login( ),
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
              login();
            },
            style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),
            child: const Text(
              'Login',
             ),
          ),
        ],
      ),
    );
  }
}
