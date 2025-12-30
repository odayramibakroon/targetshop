import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/categories_model.dart';
import '../models/products_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<Category>> getCategories();
  Stream<List<ProductsModel>> getProducts({required String categoryId});

  Future<void> toggleLike({
    required String categoryId,
    required String productId,
    required bool isLiked,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Category>> getCategories() async {
    final snapshot = await firestore.collection('categories').get();
    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs
        .map((doc) => Category(
              id: doc.id,
              name: doc['name'] ?? '',
              details: doc['details'] ?? '',
              image: doc['image'] ?? '',
            ))
        .toList();
  }

  @override
  Stream<List<ProductsModel>> getProducts({required String categoryId}) {
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductsModel.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> toggleLike({
    required String categoryId,
    required String productId,
    required bool isLiked,
  }) async {
  

    return await firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc(productId)
        .update({'like': isLiked});
  }
}
