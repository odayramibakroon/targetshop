import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:targetshop/src/features/home/data/models/products_model.dart';

abstract class CartRemoteDataSource {
  Stream<List<ProductsModel>> streamUserProducts();
}

class CartRemoteDataSourceImp implements CartRemoteDataSource {
  @override
  Stream<List<ProductsModel>> streamUserProducts() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return ProductsModel.fromFirestore(data, doc.id);
            }).toList());


  }



}
