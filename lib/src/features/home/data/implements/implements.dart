
 
 
import '../../domain/entities/categories_entity.dart';
import '../models/products_model.dart';
import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class HomeRepositoryImp implements HomeRepository{

        final HomeRemoteDataSource remoteDataSource;
        HomeRepositoryImp({required this.remoteDataSource});

  @override
    Future<List<Category>> getCategories() async {
      return await remoteDataSource.getCategories();
  }

  @override
 Stream<List<ProductsModel>> getProducts ({required String categoryId})  {
         return   remoteDataSource.getProducts(categoryId: categoryId);
  }
      
      @override
  Future<void> toggleLike({
    required String categoryId,
    required String productId,
    required bool isLiked,
  }) {
    return remoteDataSource.toggleLike(
      categoryId: categoryId,
      productId: productId,
      isLiked: isLiked,
    );
  }
    }
    