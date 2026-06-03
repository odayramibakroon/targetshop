import '../../data/models/products_model.dart';
import '../entities/categories_entity.dart';

abstract class HomeRepository {
  Future<List<Category>> getCategories();
  Stream<List<ProductsModel>> getProducts({required String categoryId});
  Future<void> toggleLike({
    required String categoryId,
    required String productId,
    required bool isLiked,
  });
  Future<void> addCategory(Category category);

}
