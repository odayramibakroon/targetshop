 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
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
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    final user = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel.fromFirebase(user.user!);
  }
  
  @override
  Future<void> addUser({required String uid, required String firstname, required String lastname, required int age, required String email}) async{


      await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });  }
}