import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Text("data"),
             ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, RoutesName.login);
  },
  child: Text(
    "انتقال للصفحة",
    style: TextStyle(fontSize: 18),
  ),
)

          ],
        ),
      ),
    );
  }

  
}
