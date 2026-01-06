import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/src/features/users/cubit/user_cubit.dart';

import '../../../../core/routes/names.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
                  
                   context.read<UserCubit>().clearUser();
                       Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.login,
                  (route) => false,
                );
                  
                }).catchError((error) {
                  print('حدث خطأ: $error');
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
 
 
    );
  }
}
