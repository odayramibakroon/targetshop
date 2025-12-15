
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class ChatRepositoryImp implements ChatRepository{

        final ChatRemoteDataSource remoteDataSource;
        ChatRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    