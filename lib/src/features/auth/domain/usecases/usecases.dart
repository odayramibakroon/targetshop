 
 
import '../entities/entities.dart';
import '../repositories/repositories.dart';

  class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<AuthEntity> call({
    required String email,
    required String password,
  }) {
    return repository.signUp(email: email, password: password);
  }
}