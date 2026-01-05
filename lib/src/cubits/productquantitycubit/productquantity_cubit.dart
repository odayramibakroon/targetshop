import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductQuantityCubit extends Cubit<double> {
  final String productId;
  final String image;
  final double price;
  final String name;
  final String categoryId;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  ProductQuantityCubit(  {
    required this.productId,
    required this.image,
    required this.price,
    required this.name,
    required this.categoryId,
    required double initialQuantity,
  }) : super(initialQuantity);

  Future<void> increment() async {

  try{  final newQuantity = state + 1;
    emit(newQuantity); // تحديث محلي فوراً
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('products')
        .doc(productId)
        .set({
          'quantity': newQuantity,
          'name': name,
          'image': image,
          'price': price,
  
        });}
        catch(e){
          print("Error in incrementing quantity: $e");
        }

        
  }

  Future<void> decrement() async {
    if (state <= 0) return;

    final newQuantity = state - 1;
    emit(newQuantity);  

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('products')
        .doc(productId);

    if (newQuantity == 0) {
      // حذف المنتج إذا الكمية 0
      await docRef.delete();
    } else {
      // تحديث الكمية
      await docRef.set({
          'quantity': newQuantity,
          'name': name,
          'image': image,
          'price': price,
  
        });
    }
  }
}
