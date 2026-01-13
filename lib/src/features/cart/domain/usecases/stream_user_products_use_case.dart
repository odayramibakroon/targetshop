import 'package:targetshop/src/features/cart/domain/repositories/repositories.dart';
import 'package:targetshop/src/features/home/data/models/products_model.dart';

class StreamUserProductsUseCase {
        final CartRepository repository;

  StreamUserProductsUseCase({required this.repository});

           Stream<List<ProductsModel>> call()   {
          return repository.streamUserProducts();
        }
}