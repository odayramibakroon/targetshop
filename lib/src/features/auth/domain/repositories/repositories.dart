 
 
import '../entities/entities.dart';

abstract class AuthRepository {
  Future<AuthEntity> signUp({
    required String email,
    required String password,
  });    
  
 
  
  
  
  
  
    }
    