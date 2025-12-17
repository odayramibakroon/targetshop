import '../../domain/entities/entities.dart';
import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthEntity> signUp({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> addUser(
      {required String uid,
      required String firstname,
      required String lastname,
      required int age,
      required String email}) async {
    await remoteDataSource.addUser(
        uid: uid,
        firstname: firstname,
        lastname: lastname,
        age: age,
        email: email);
  }
}
