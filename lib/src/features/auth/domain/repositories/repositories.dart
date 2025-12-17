 
 
import '../entities/entities.dart';

abstract class AuthRepository {
  Future<AuthEntity> signUp({
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
    