import 'package:targetshop/src/features/home/data/models/products_model.dart';

abstract class CartRepository {
   Stream<List<ProductsModel>> streamUserProducts();
}
