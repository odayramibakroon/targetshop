 
 
import 'package:targetshop/src/features/auth/domain/entities/auth_register_entity.dart';

import '../entities/entities.dart';
import '../repositories/repositories.dart';

  class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthRegisterEntity> call({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
   
  }) {
    return repository.signUp(email: email, password: password,firstname: firstname,lastname: lastname,age: age );
  }
}