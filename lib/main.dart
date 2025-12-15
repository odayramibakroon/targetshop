 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'src/features/auth/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await DependencyInjection.init(); 
print("AuthCubit registered? ${getIt.isRegistered<AuthCubit>()}");

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      if (kDebugMode) print('User is currently signed out!');
    } else {
      if (kDebugMode) print('User is signed in!');
    }
  });

  runApp(const MyApp());
}
