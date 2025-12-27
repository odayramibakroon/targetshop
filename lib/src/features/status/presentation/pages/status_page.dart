import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/names.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
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
      ),);
  }
}
