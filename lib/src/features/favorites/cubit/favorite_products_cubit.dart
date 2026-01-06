import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:targetshop/src/features/favorites/domain/usecases/favorite_products_usecase.dart';
 import 'favorite_products_state.dart';

class FavoriteProductsCubit extends Cubit<FavoriteProductsState> {
  final GetFavoriteProductsUseCase getFavoriteProductsUseCase;

  StreamSubscription? _subscription;

  FavoriteProductsCubit(this.getFavoriteProductsUseCase)
      : super(FavoriteProductsInitial());

  void loadFavoriteProducts({required String categoryId}) {
    emit(FavoriteProductsLoading());

    _subscription?.cancel();

    _subscription = getFavoriteProductsUseCase(
  
    ).listen(
      (products) {
        emit(FavoriteProductsLoaded(products));
      },
      onError: (error) {
        emit(FavoriteProductsError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
