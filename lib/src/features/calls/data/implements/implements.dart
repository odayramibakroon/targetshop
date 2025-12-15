
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class CallsRepositoryImp implements CallsRepository{

        final CallsRemoteDataSource remoteDataSource;
        CallsRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    