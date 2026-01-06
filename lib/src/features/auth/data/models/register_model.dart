import 'package:firebase_auth/firebase_auth.dart';
import 'package:targetshop/src/features/auth/domain/entities/auth_register_entity.dart';

class RegisterModel extends AuthRegisterEntity {
  const RegisterModel({
    required super.uid,
    required super.email,
  });

  factory RegisterModel.fromFirebase(User user) {
    return RegisterModel(
      uid: user.uid,
      email: user.email ?? "",
    );
  }
}