 
    import 'package:targetshop/src/features/favorites/data/models/favorite_product_model.dart';
import 'package:targetshop/src/features/favorites/domain/favorite_products_entity.dart';

abstract class FavoritesRepository {
        // Future<User> getUser(String userId);
           Stream<List<FavoriteProductModel>> getFavoriteProducts( );
      }
    