// domain/usecases/get_favorite_products_usecase.dart
import 'package:targetshop/src/features/favorites/data/models/favorite_product_model.dart';
 import 'package:targetshop/src/features/favorites/domain/repositories/repositories.dart';

 

class GetFavoriteProductsUseCase {
  final FavoritesRepository repository;

  GetFavoriteProductsUseCase(this.repository );

  Stream<List<FavoriteProductModel>> call( ) {
    return repository.getFavoriteProducts( );
  }
}
