import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../../../core/config/config.dart';

import '../../../../core/routes/names.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/form_login.dart';
import '../widgets/logo_grocery.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(8),
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Welcome ${state.user.email}!")),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.MainLayout,
                      (route) => false,
                    );
                  }

                  if (state is LoginFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(
                        context,
                      ).size.height,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LogoAndWelcome(),
                          SizedBox(height: 20),
                          FormLogin(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                void login() async {
                                  try {
                                    try {
                                      String _emailController = "bak@gmail.com";
                                      String _passwordController = "123456";
                                      await context.read<AuthCubit>().login(
                                            email: _emailController,
                                            password: _passwordController,
                                          );
                                      setState(() {
                                        _emailController = "";
                                        _passwordController = "";
                                      });
                                    } catch (e) {
                                      print("Error: $e");
                                    }
                                  } catch (e) {
                                    print("catch $e");
                                  }
                                }

                                login();
                              },
                              child: const Text(
                                "Forget Password?",
                               
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  label: const Text(
                                    "Google",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.apple,
                                      color: Colors.black),
                                  label: const Text(
                                    "Apple",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don’t have an account? ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  try {
                                    Navigator.pushNamed(
                                        context, RoutesName.register);
                                  } catch (e) {
                                    print("0595912390 ${e.toString()}");
                                  }
                                },
                                child: const Text(
                                  "Sign Up",
                                   
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                  ///
                },
              ),
            ),
          ),
        ));
  }
}
///////////dev
