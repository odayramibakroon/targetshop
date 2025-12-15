
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class SettingsRepositoryImp implements SettingsRepository{

        final SettingsRemoteDataSource remoteDataSource;
        SettingsRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    