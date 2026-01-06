// data/repositories_impl/favorites_repository_impl.dart
 import 'package:targetshop/src/features/favorites/data/models/favorite_product_model.dart';
import 'package:targetshop/src/features/favorites/data/sources/sources.dart';
 import 'package:targetshop/src/features/favorites/domain/repositories/repositories.dart';

 
 
class FavoritesRepositoryImpl implements FavoritesRepository {
        final FavoriteProductRemoteDataSource remoteDataSource;
 

  FavoritesRepositoryImpl(this.remoteDataSource );

  @override
  Stream<List<FavoriteProductModel>> getFavoriteProducts( )  {

  return   remoteDataSource.getFavoriteProducts( );
  }
}
