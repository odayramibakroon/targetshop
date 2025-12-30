import '../../data/models/products_model.dart';
 import '../repositories/repositories.dart';

class GetProductsByCategoryUseCase {
  final HomeRepository repository;

  GetProductsByCategoryUseCase({required this.repository});

   Stream<List<ProductsModel>> call({required String categoryId}) {
    return repository.getProducts(categoryId: categoryId);
  }
}
