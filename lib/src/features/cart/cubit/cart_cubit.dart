import 'dart:async';

import 'package:bloc/bloc.dart';
 import 'package:targetshop/src/features/cart/cubit/cart_state.dart';
import 'package:targetshop/src/features/cart/domain/usecases/stream_user_products_use_case.dart';
import 'package:targetshop/src/features/home/data/models/products_model.dart';
class CartCubit extends Cubit<CartState> {
  final StreamUserProductsUseCase streamUserProductsUseCase;

  StreamSubscription? _subscription;

  CartCubit(this.streamUserProductsUseCase )
      : super(CartInitial());

  Stream<List<ProductsModel>> loadCartProducts( ) {
    emit(CartLoading());

    _subscription?.cancel();

    _subscription = streamUserProductsUseCase(
    ).listen(
      (products) {
        emit(CartLoaded(products));
      },
      onError: (error) {
        emit(CartError(error.toString()));
      },
    );
    return streamUserProductsUseCase();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
