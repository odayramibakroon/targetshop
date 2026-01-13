import 'package:targetshop/src/features/home/data/models/products_model.dart';

abstract class CartRepository {
  // Future<User> getUser(String userId);
  Stream<List<ProductsModel>> streamUserProducts();
}
