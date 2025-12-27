import '../entities/entities.dart';
import '../repositories/repositories.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<AuthEntity> call({
    required String email,
    required String password,
  }) {
    return repo.login(email: email, password: password);
  }
}
