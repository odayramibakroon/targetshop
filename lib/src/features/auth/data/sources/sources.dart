import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:targetshop/src/features/auth/data/models/register_model.dart';

import '../models/models.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterModel> signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
   });
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> addUser({
    required String uid,
    required String firstname,
    required String lastname,
    required int age,
    required String email,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<RegisterModel> signUp(
      {required String password,
      required String firstname,
      required String lastname,
      required int age,
      required String email}) async {
    final user = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uidu = user.user!;
    final uid = uidu.uid;
    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return RegisterModel.fromFirebase(user.user!);
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user!;
      return UserModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    }
  }

  @override
  Future<void> addUser(
      {required String uid,
      required String firstname,
      required String lastname,
      required int age,
      required String email}) async {
    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
