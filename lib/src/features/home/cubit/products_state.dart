part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final Stream<List<ProductsModel>> Products;
  ProductsLoaded(this.Products);
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}