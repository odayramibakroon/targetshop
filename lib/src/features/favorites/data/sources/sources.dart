 
   import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:targetshop/src/features/favorites/data/models/favorite_product_model.dart';

abstract class  FavoriteProductRemoteDataSource {
        // Make API call to fetch data and return object.
        // ...
         Stream<List<FavoriteProductModel>> getFavoriteProducts(  );
    }



    class FavoriteProductRemoteDataSourceImpl implements FavoriteProductRemoteDataSource {
  final FirebaseFirestore firestore;

  FavoriteProductRemoteDataSourceImpl({required this.firestore});
 

  @override
Stream<List<FavoriteProductModel>> getFavoriteProducts( ) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('users')
      .doc(uid)
      .collection('favorites')
      .snapshots()
      .switchMap((favSnapshot) {
    if (favSnapshot.docs.isEmpty) return Stream.value([]);

    final productStreams = favSnapshot.docs.map((doc) {
      final categoryId = doc['categoryId'] as String;
      final productId = doc['productId'] as String;

       final productDocStream = firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .snapshots();

      final quantityStream = firestore
          .collection('users')
          .doc(uid)
          .collection('products')
          .doc(productId)
          .snapshots()
          .map((qDoc) => qDoc.exists ? (qDoc.data()?['quantity'] ?? 0).toDouble() : 0.0);

      // دمج المنتج مع الكمية
return Rx.combineLatest2(productDocStream, quantityStream,
    (productDoc, quantityDynamic) {
  if (!productDoc.exists) return null;

  final data = productDoc.data()!;
  final quantity = (quantityDynamic ?? 0).toDouble(); // تحويل dynamic إلى double

  return FavoriteProductModel(
    id: productDoc.id,
    name: data['name'] ?? '',
    details: data['details'] ?? '',
    price: (data['price'] ?? 0).toDouble(),
    image: data['image'] ?? '',
    quantity: quantity, // استخدمنا الكمية بعد التحويل
    categoryId: categoryId,
    like: true,
  );
});

    }).toList();

    return Rx.combineLatestList<FavoriteProductModel?>(productStreams)
        .map((products) => products.whereType<FavoriteProductModel>().toList());
  });
}
 


}
