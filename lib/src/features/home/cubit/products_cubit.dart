import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../data/models/products_model.dart';
import '../domain/usecases/getproducts.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsByCategoryUseCase getProductsByCategory;
  StreamSubscription<List<ProductsModel>>? _subscription;

  ProductsCubit( {required this.getProductsByCategory})
      : super(ProductsInitial());
 
  void fetchProducts(String categoryId) {
    emit(ProductsLoading());

    _subscription?.cancel();    

    _subscription = getProductsByCategory(categoryId: categoryId).listen(
      (products) {
        emit(ProductsLoaded(products as Stream<List<ProductsModel>>));
      },
      onError: (error) {
        emit(ProductsError(error.toString()));
      },
    );
  }





  Future<void> minProduct({
  required String productId,
  required double currentQuantity,
    required String categoryId,
}) async {
  if (currentQuantity <= 0) {

  } 
else {
  await FirebaseFirestore.instance
   .collection('categories')
      .doc(categoryId)
      .collection('products')
            .doc(productId)
      .update({
    'quantity': currentQuantity - 1,
  });
}

}



  Future<void> addProduct({
  required String productId,
  required double currentQuantity,
    required String categoryId,
}) async {
  if (currentQuantity < 0) {

  } 
else {
  await FirebaseFirestore.instance
   .collection('categories')
      .doc(categoryId)
      .collection('products')
            .doc(productId)
      .update({
    'quantity': FieldValue.increment(1),
  });
}

}

 

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

