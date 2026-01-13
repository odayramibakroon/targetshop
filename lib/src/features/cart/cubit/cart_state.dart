import 'package:meta/meta.dart';
 import 'package:targetshop/src/features/home/domain/entities/product_entity.dart'; 
@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List< Product> products;

  CartLoaded(this.products);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
