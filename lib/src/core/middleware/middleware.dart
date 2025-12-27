library middleware;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Middleware {
  late final Stream<User?> authStream;

  Middleware() {
    authStream = FirebaseAuth.instance.authStateChanges();
  }
  void listenAuthState() {
    authStream.listen((User? user) {
      if (user == null) {
        
        if (kDebugMode) print('User is currently signed out!');
      } else {
        if (kDebugMode) print('User is signed in!');
      }
    });
  }
}
