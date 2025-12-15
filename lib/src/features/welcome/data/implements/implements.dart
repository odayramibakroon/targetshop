
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class WelcomeRepositoryImp implements WelcomeRepository{

        final WelcomeRemoteDataSource remoteDataSource;
        WelcomeRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    