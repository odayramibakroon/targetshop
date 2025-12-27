 
 
import '../entities/entities.dart';
import '../repositories/repositories.dart';

  class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthEntity> call({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
   
  }) {
    return repository.signUp(email: email, password: password,firstname: firstname,lastname: lastname,age: age );
  }
}