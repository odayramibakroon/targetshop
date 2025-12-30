 
    import '../entities/categories_entity.dart';
import '../repositories/repositories.dart';

    class GetHomeUseCase {
        final HomeRepository repository;
      
        GetHomeUseCase(  {required this.repository});
        Future<List<Category>> call() {
    return repository.getCategories();
  }
        // Future<User> execute(String userId) async {
        //   return userRepository.getUser(userId);
        // }
      }
      