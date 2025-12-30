
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class StatusRepositoryImp implements StatusRepository{

        final StatusRemoteDataSource remoteDataSource;
        StatusRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    