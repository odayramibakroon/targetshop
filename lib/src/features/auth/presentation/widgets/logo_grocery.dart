 import 'package:flutter/material.dart';
import 'package:targetshop/src/core/theme/colors.dart';
 
class LogoGrocery extends StatelessWidget {
  const LogoGrocery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // 👈 أسهل من borderRadius
        gradient: LinearGradient(
          colors: [
  
            const Color.fromARGB(255, 204, 241, 181),
            const Color.fromARGB(255, 87, 239, 5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.shopping_cart_outlined, // أيقونة أنعم
          size: 70,
          color: Colorsapp.primary,
        ),
      ),
    );
  }
}
class LogoAndWelcome extends StatelessWidget {
  const LogoAndWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LogoGrocery(),
      Text("Welcome To Our", style: TextStyle(fontSize: 28)),
        Text(
          "E-Grocery",
          style: TextStyle(fontSize: 28, color: Colorsapp.primary),
        ),
       
      ],
    );
  }
}