 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetshop/src/core/routes/names.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((_) {
                  print('تم الروج 🚪');
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                }).catchError((error) {
                  print('حدث خطأ: $error');
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
             Text("data"),
             ElevatedButton(
  onPressed: () {
    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.login,
                           (route) => false,
                        );  },
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
