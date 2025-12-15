
 
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
}
    