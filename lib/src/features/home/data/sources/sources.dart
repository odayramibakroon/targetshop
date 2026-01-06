import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/categories_entity.dart';
 
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
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('categories')
      .doc(categoryId)
      .collection('products')
      .snapshots()
      .asyncMap((productsSnapshot) async {
        
    // جلب المفضلة للمستخدم
    final favSnapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();
    final favoriteIds = favSnapshot.docs.map((doc) => doc['productId'] as String).toSet();

    // جلب كميات المستخدم من collection منفصل
    final userProductsSnapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .get();
    final userQuantities = {
      for (var doc in userProductsSnapshot.docs) doc.id: (doc.data()['quantity'] ?? 0).toDouble()
    };

    // إنشاء قائمة المنتجات مع الكمية الخاصة باليوزر
    return productsSnapshot.docs.map((doc) {
      final data = doc.data();
      final userQuantity = userQuantities[doc.id] ?? 0.0; // إذا ما عنده كمية = 0
      return ProductsModel(
        id: doc.id,
        name: data['name'] ?? '',
        details: data['details'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        image: data['image'] ?? '',
        quantity: userQuantity, // كمية المستخدم هنا
        categoryId: categoryId,
        like: favoriteIds.contains(doc.id),
      );
    }).toList();
  });
}

final uid = FirebaseAuth.instance.currentUser!.uid;
@override
Future<void> toggleLike({
  required String categoryId,
  required String productId,
  required bool isLiked,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final docRef = firestore
      .collection('users')
      .doc(uid)
      .collection('favorites')
      .doc(productId); // استخدمي productId بدل categoryId

  if (isLiked) {
    // إضافة للمفضلة
    await docRef.set({
      'categoryId': categoryId,
      'productId': productId,
      'isLiked': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  } else {
    // إزالة من المفضلة
    await docRef.delete();
  }
}


}
