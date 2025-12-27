import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../../../../core/routes/names.dart';
import '../../../../core/utils/AppValidators.dart';
import '../../cubit/auth_cubit.dart';
import '../../domain/usecases/adduserusecase.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
//bgbg@bgb.com
class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController EmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  int convertage() {
    return int.parse(ageController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignUpSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Welcome ${state.user.email}!")),
                  );
                  Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false,);
                }

                if (state is SignUpFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errMessage)),
                  );
                }
              },
              //cscs@frr.com 123456
               
              builder: (context, state) {
                return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        _buildInput(
                          label: "Email",
                          controller: EmailController,
                          icon: Icons.person,
                          validator: (value) {
                            return AppValidators.email(value);
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildInput(
                          label: "Password",
                          controller: passwordController,
                          icon: Icons.lock,
                          isPassword: true,
                          validator: (value) {
                            return AppValidators.password(value);
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildInput(
                          label: "First Name",
                          controller: firstNameController,
                          icon: Icons.account_circle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildInput(
                          label: "Last Name",
                          controller: lastNameController,
                          icon: Icons.account_circle_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildInput(
                          label: "Age",
                          controller: ageController,
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Age is required";
                            }
                            if (int.tryParse(value) == null) {
                              return "Enter a valid number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  // تسجيل المستخدم
                                  await context.read<AuthCubit>().signUp(
                                        email: EmailController.text,
                                        firstname: firstNameController.text,
                                        password: passwordController.text,
                                        lastname: lastNameController.text,
                                        age: convertage(),
                                      );
                                } catch (e) {
                                  print("Error: $e");
                                }
                              }
                            },
                            child: const Text(
                              "Create Account",
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  // Custom Input Widget
  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    Function(String)? onChanged,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}









/* 
       onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                   await context.read<AuthCubit>().login(
                                        email: EmailController.text,
                                         password: passwordController.text,
                                       );
                                } catch (e) {
                                  print("Error: $e");
                                }
                              }
                            }, */