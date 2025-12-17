 
 import '../repositories/repositories.dart';

class AddUserUseCase {
  final AuthRepository repository;

  AddUserUseCase(this.repository);

  Future<void> call({
    required String uid,
    required String firstname,
    required String lastname,
    required int age,
    required String email,
  }) async {
    return repository.addUser(
      uid: uid,
      firstname: firstname,
      lastname: lastname,
      age: age,
      email: email,
    );
  }
}
