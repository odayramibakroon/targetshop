import 'package:meta/meta.dart';
import 'package:targetshop/src/features/favorites/domain/favorite_products_entity.dart';
 
@immutable
abstract class FavoriteProductsState {}

class FavoriteProductsInitial extends FavoriteProductsState {}

class FavoriteProductsLoading extends FavoriteProductsState {}

class FavoriteProductsLoaded extends FavoriteProductsState {
  final List<FavoriteProductsEntity> products;

  FavoriteProductsLoaded(this.products);
}

class FavoriteProductsError extends FavoriteProductsState {
  final String message;

  FavoriteProductsError(this.message);
}
